import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../logging.dart';
import 'push_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class _AndroidNotificationConstants {
  static const channelId = 'default_notifications';
  static const channelName = 'Default Notifications';
  static const channelDescription = 'This channel is used for default notifications.';
  static const androidIcon = '@drawable/ic_notification';
}

class DefaultPushNotificationsClient implements PushNotificationsClient {
  DefaultPushNotificationsClient();

  final _localNotifications = FlutterLocalNotificationsPlugin();
  final _firebaseMessaging = FirebaseMessaging.instance;

  final StreamController<String?> _onClickController =
      StreamController.broadcast();

  final AndroidNotificationChannel _androidChannel =
      const AndroidNotificationChannel(
    _AndroidNotificationConstants.channelId,
    _AndroidNotificationConstants.channelName,
    description: _AndroidNotificationConstants.channelDescription,
    importance: Importance.max,
  );

  @override
  Stream<String?> get onNotificationClick => _onClickController.stream;

  @override
  Future<String?> getFcmToken() async {
    try {
      return await _firebaseMessaging.getToken();
    } catch (e) {
      throw Exception("Failed to retrieve Firebase Cloud Messaging token - $e");
    }
  }

  @override
  Future<void> init() async {
    try {
      tz.initializeTimeZones();

      await requestPermission();

      if (defaultTargetPlatform == TargetPlatform.android) {
        await _localNotifications
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(_androidChannel);
      }

      await _initLocalNotifications();
      await _initFirebase();

      AppLogger().logMessage("FCM TOKEN: ${await getFcmToken()}");
    } catch (e) {
      throw Exception("Failed to initialize push notifications - $e");
    }
  }

  Future<void> _initLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings(
            _AndroidNotificationConstants.androidIcon);

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    const InitializationSettings initSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) {
        if (response.payload != null && response.payload!.isNotEmpty) {
          _onClickController.add(response.payload);
        }
      },
    );
  }

  Future<void> _initFirebase() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: false,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;

      if (notification != null) {
        int notificationId;
        final messageData = message.data;

        if (messageData['id'] != null) {
          try {
            notificationId = int.parse(messageData['id'].toString());
          } catch (e) {
            notificationId = Random().nextInt(1000000);
          }
        } else {
          notificationId = Random().nextInt(1000000);
        }

        showNotification(
          id: notificationId,
          title: notification.title ?? '',
          body: notification.body ?? '',
          payload: message.data,
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _onClickController.add(jsonEncode(message.data));
    });

    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _onClickController.add(jsonEncode(initialMessage.data));
    }
  }

  @override
  Future<bool> requestPermission() async {
    final permission = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    return permission.authorizationStatus == AuthorizationStatus.authorized;
  }

  NotificationDetails _notificationDetails() {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        _androidChannel.id,
        _androidChannel.name,
        channelDescription: _androidChannel.description,
        icon: _AndroidNotificationConstants.androidIcon,
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
  }

  @override
  Future<void> showNotification({
    required String title,
    required String body,
    int? id,
    Map<String, dynamic>? payload,
  }) async {
    id ??= Random().nextInt(1000000);

    await _localNotifications.show(
      id,
      title,
      body,
      _notificationDetails(),
      payload: payload != null ? jsonEncode(payload) : null,
    );
  }

  @override
  Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledDate,
    int? id,
    Map<String, dynamic>? payload,
  }) async {
    id ??= Random().nextInt(1000000);

    await _localNotifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      _notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload != null ? jsonEncode(payload) : null,
    );
  }

  @override
  Future<void> cancelNotification(int id) async {
    await _localNotifications.cancel(id);
  }

  @override
  Future<void> cancelAllNotifications() async {
    await _localNotifications.cancelAll();
  }

  @override
  void dispose() {
    _onClickController.close();
  }
}
