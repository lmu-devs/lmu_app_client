import 'package:core/components.dart';
import 'package:flutter/material.dart';

import '../views/settings_success_view.dart';

class SettingsMainPage extends StatelessWidget {
  const SettingsMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LmuScaffoldWithAppBar(
      largeTitle: "Settings",
      body: SettingsSuccessView(),
    );
  }
}
