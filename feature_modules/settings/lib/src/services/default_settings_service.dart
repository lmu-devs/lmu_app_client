import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_api/settings.dart';

import '../../settings.dart';
import '../routes/settings_routes.dart';

class DefaultSettingsService implements SettingsService {
  @override
  void navigateToSettings(BuildContext context) {
    const SettingsMainRoute().go(context);
    //Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettingsMainPage()));
  }

  @override
  RouteBase get settingsData => $settingsMainRoute;
}
