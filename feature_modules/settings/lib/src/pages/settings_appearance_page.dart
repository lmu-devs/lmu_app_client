import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsApperancePage extends StatelessWidget {
  const SettingsApperancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final localization = context.locals.settings;

    return LmuMasterAppBar(
      largeTitle: localization.appearance,
      leadingAction: LeadingAction.back,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(LmuSizes.size_16),
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
