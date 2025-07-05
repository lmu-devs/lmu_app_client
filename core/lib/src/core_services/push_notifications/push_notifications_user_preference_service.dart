import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationsUserPreferenceService {
  final ValueNotifier<PermissionStatus?> permissionStatus = ValueNotifier(null);

  Future<void> refreshStatus() async {
    permissionStatus.value = null;
    permissionStatus.value = await Permission.notification.status;
  }
}
