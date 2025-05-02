import 'package:core_routes/settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_api/settings.dart';

class DefaultSettingsService implements SettingsService {
  @override
  void navigateToSettings(BuildContext context) {
    const SettingsMainRoute().go(context);
  }
}
