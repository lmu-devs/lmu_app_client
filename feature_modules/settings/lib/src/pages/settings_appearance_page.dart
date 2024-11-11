import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:core/localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingsApperancePage extends StatelessWidget {
  const SettingsApperancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return LmuScaffoldWithAppBar(
      largeTitle: context.localizations.settingsAppearance,
      leadingWidget: GestureDetector(
        onTap: () {
          context.pop();
        },
        child: const LmuIcon(
          icon: Icons.arrow_back,
          size: 28,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(LmuSizes.mediumLarge),
        child: LmuContentTile(
          content: [
            LmuListItem.action(
              title: context.localizations.settingsSystemMode,
              actionType: LmuListItemAction.radio,
              initialValue: themeProvider.themeMode == ThemeMode.system,
              onTap: () {
                themeProvider.setThemeMode(ThemeMode.system);
              },
            ),
            LmuListItem.action(
              title: context.localizations.settingsLightMode,
              actionType: LmuListItemAction.radio,
              initialValue: themeProvider.themeMode == ThemeMode.light,
              onTap: () {
                themeProvider.setThemeMode(ThemeMode.light);
              },
            ),
            LmuListItem.action(
              title: context.localizations.settingsDarkMode,
              actionType: LmuListItemAction.radio,
              initialValue: themeProvider.themeMode == ThemeMode.dark,
              onTap: () {
                themeProvider.setThemeMode(ThemeMode.dark);
              },
            )
          ],
        ),
      ),
    );
  }
}
