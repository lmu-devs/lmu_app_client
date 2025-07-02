abstract class PushNotificationsClient {
  Stream<String?> get onNotificationClick;

  Future<String?> getFcmToken();

  Future<void> init();

  Future<bool> requestPermission();

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    Map<String, dynamic>? payload,
  });

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    Map<String, dynamic>? payload,
  });

  Future<void> cancelNotification(int id);

  Future<void> cancelAllNotifications();

  void dispose();
}
