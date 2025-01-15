import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class SettingsService {
  void navigateToSettings(BuildContext context);

  RouteBase get settingsData;
}
