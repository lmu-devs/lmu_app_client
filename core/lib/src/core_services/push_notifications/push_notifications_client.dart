abstract class PushNotificationsClient {
  Stream<String?> get onNotificationClick;

  Future<void> init();

  Future<void> requestPermission();

  Future<bool?> hasShownPermissionsRequest();

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
