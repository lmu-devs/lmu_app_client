import 'dart:io' show Platform;
import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> askForLocationPermission({required BuildContext context, required bool askEveryTime}) async {
  PermissionStatus status = await Permission.location.status;

  if (status.isGranted) {
    if (context.mounted) {
      await _checkLocationServices(context);
    }
  } else if (status.isDenied || status.isRestricted) {
    PermissionStatus request = await Permission.location.request();
    if (request.isGranted) {
      if (context.mounted) {
        await _checkLocationServices(context);
      }
    }
  } else if (status.isPermanentlyDenied && askEveryTime) {
    if (context.mounted) {
      await _showSettingsDialog(context);
    }
  } else if (status.isLimited) {
    if (context.mounted) {
      await _checkLocationServices(context);
    }
  }
}

Future<void> _checkLocationServices(BuildContext context) async {
  bool isLocationServicesEnabled = await Permission.location.serviceStatus.isEnabled;

  if (isLocationServicesEnabled) {
    return;
  } else {
    if (context.mounted) {
      await _showLocationServicesInfoDialog(context);
    }
  }
}

Future<void> _showLocationServicesInfoDialog(BuildContext context) async {
  if (Platform.isIOS) {
    await showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: LmuText(
          context.locals.app.locationServiceDialogTitle,
          weight: FontWeight.w600,
        ),
        content: LmuText.bodyXSmall(context.locals.app.locationServiceDialogText),
        actions: [
          CupertinoDialogAction(
            child: LmuText.body(context.locals.app.ok),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  } else {
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: LmuText(
          context.locals.app.locationServiceDialogTitle,
          weight: FontWeight.w600,
        ),
        content: LmuText.bodyXSmall(context.locals.app.locationServiceDialogText),
        actions: [
          TextButton(
            child: LmuText.body(context.locals.app.cancel),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

Future<void> _showSettingsDialog(BuildContext context) async {
  if (Platform.isIOS) {
    await showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: LmuText(
          context.locals.app.locationPermissionDialogTitle,
          weight: FontWeight.w600,
        ),
        content: LmuText.bodyXSmall(context.locals.app.locationPermissionDialogText),
        actions: [
          CupertinoDialogAction(
            child: LmuText.body(context.locals.app.cancel),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: LmuText.body(
              context.locals.app.settings,
              color: context.colors.brandColors.backgroundColors.nonInvertableColors.active,
            ),
            onPressed: () async {
              Navigator.pop(context);
              await openAppSettings();
            },
          ),
        ],
      ),
    );
  } else {
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: LmuText(
          context.locals.app.locationPermissionDialogTitle,
          weight: FontWeight.w600,
        ),
        content: LmuText.bodyXSmall(context.locals.app.locationPermissionDialogText),
        actions: [
          TextButton(
            child: LmuText.body(context.locals.app.cancel),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: LmuText.body(
              context.locals.app.settings,
              color: context.colors.brandColors.backgroundColors.nonInvertableColors.active,
            ),
            onPressed: () async {
              Navigator.pop(context);
              await openAppSettings();
            },
          ),
        ],
      ),
    );
  }
}
