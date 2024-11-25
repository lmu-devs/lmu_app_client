import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsAccountPage extends StatelessWidget {
  const SettingsAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final localization = context.locals.settings;

    return LmuScaffoldWithAppBar(
      largeTitle: "localization.account",
      leadingAction: LeadingAction.back,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(LmuSizes.mediumLarge),
            child: LmuContentTile(
              content: [
                LmuListItem.action(
                  title: localization.systemMode,
                  actionType: LmuListItemAction.radio,
                  initialValue: themeProvider.themeMode == ThemeMode.system,
                  onTap: () {
                    themeProvider.setThemeMode(ThemeMode.system);
                  },
                ),
                LmuListItem.action(
                  title: localization.lightMode,
                  actionType: LmuListItemAction.radio,
                  initialValue: themeProvider.themeMode == ThemeMode.light,
                  onTap: () {
                    themeProvider.setThemeMode(ThemeMode.light);
                  },
                ),
                LmuListItem.action(
                  title: localization.darkMode,
                  actionType: LmuListItemAction.radio,
                  initialValue: themeProvider.themeMode == ThemeMode.dark,
                  onTap: () {
                    themeProvider.setThemeMode(ThemeMode.dark);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
