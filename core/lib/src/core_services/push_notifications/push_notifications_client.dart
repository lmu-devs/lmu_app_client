abstract class PushNotificationsClient {
  Stream<String?> get onNotificationClick;

  Future<String?> getFcmToken();

  Future<void> init();

  Future<bool> requestPermission();

  Future<void> showNotification({
    required String title,
    required String body,
    int? id,
    Map<String, dynamic>? payload,
  });

  Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledDate,
    int? id,
    Map<String, dynamic>? payload,
  });

  Future<void> cancelNotification(int id);

  Future<void> cancelAllNotifications();

  void dispose();
}
