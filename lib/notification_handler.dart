import 'dart:async';
import 'dart:convert';
import 'package:core/core_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'router_config.dart';

class NotificationsHandler extends StatefulWidget {
  const NotificationsHandler({super.key, required this.child});

  final Widget child;

  @override
  State<NotificationsHandler> createState() => _NotificationsHandlerState();
}

class _NotificationsHandlerState extends State<NotificationsHandler> {
  StreamSubscription<String?>? _notificationSubscription;

  @override
  void initState() {
    super.initState();
    _listenToNotificationClicks();
  }

  void _listenToNotificationClicks() {
    final pushNotificationsClient = GetIt.I.get<PushNotificationsClient>();
    _notificationSubscription =
        pushNotificationsClient.onNotificationClick.listen((payload) {
          if (payload == null || payload.isEmpty) return;

          try {
            final payloadData = jsonDecode(payload);

            if (payloadData.containsKey('destination')) {
              final route = payloadData['destination'];
              LmuRouterConfig.router.go(route);
            }
          } catch (e) {
            throw Exception("Could not handle click on notification - $e - Payload: $payload");
          }
        });
  }

  @override
  void dispose() {
    _notificationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
