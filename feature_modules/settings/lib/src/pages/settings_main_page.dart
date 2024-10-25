import 'package:core/components.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../views/settings_success_view.dart';

class SettingsMainPage extends StatelessWidget {
  const SettingsMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.neutralColors.backgroundColors.base,
      appBar: const LmuDefaultNavigationBar(
        title: "Settings",
      ),
      body: const SettingsSuccessView(),
    );
  }
}
