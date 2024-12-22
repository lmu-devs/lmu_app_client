import 'package:flutter/material.dart';
import 'package:shared_api/settings.dart';

import '../pages/pages.dart';

class DefaultSettingsService implements SettingsService {
  @override
  void navigateToSettings(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettingsMainPage()));
  }
}
