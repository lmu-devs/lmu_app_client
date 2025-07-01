abstract class PushNotificationsClient {
  Stream<String?> get onNotificationClick;

  Future<void> init();

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  });

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  });

  Future<void> cancelNotification(int id);

  Future<void> cancelAllNotifications();

  void dispose();
}
