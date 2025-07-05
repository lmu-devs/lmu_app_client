import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../components.dart';
import '../../../localizations.dart';

class PermissionsService {
  static Future<bool> isLocationPermissionGranted() async => await Permission.location.isGranted;

  static Future<bool> isLocationServicesEnabled() async => await Permission.location.serviceStatus.isEnabled;

  static Future<void> showLocationPermissionDeniedDialog(BuildContext context) async {
    final appLocals = context.locals.app;
    await LmuDialog.show(
      context: context,
      title: appLocals.locationPermissionDialogTitle,
      description: appLocals.locationPermissionDialogText,
      buttonActions: [
        LmuDialogAction(
          title: appLocals.cancel,
          isSecondary: true,
          onPressed: (context) => Navigator.of(context).pop(),
        ),
        LmuDialogAction(
          title: appLocals.settings,
          icon: LucideIcons.external_link,
          onPressed: (context) {
            openAppSettings();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  static Future<void> showLocationServiceDisabledDialog(BuildContext context) async {
    final appLocals = context.locals.app;

    await LmuDialog.show(
      context: context,
      title: appLocals.locationServiceDialogTitle,
      description: appLocals.locationServiceDialogText,
      buttonActions: [
        LmuDialogAction(
          title: appLocals.cancel,
          isSecondary: true,
          onPressed: (context) => Navigator.of(context).pop(),
        ),
        LmuDialogAction(
          title: appLocals.settings,
          onPressed: (context) {
            openAppSettings();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  static bool isNotificationsPermissionGranted(PermissionStatus? status) =>
      status == PermissionStatus.granted ||
      status == PermissionStatus.provisional;

  static Future<void> showNotificationsPermissionDialog(BuildContext context) async {
    final appLocals = context.locals.app;

    await LmuDialog.show(
      context: context,
      title: appLocals.notificationsPermissionDialogTitle,
      description: appLocals.notificationsPermissionDialogText,
      buttonActions: [
        LmuDialogAction(
          title: appLocals.cancel,
          isSecondary: true,
          onPressed: (context) => Navigator.of(context).pop(),
        ),
        LmuDialogAction(
          title: appLocals.settings,
          onPressed: (context) {
            openAppSettings();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
