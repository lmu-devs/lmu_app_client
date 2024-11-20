import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingsApperancePage extends StatelessWidget {
  const SettingsApperancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final localization = context.locals.settings;

    return LmuScaffoldWithAppBar(
      largeTitle: localization.appearance,
      leadingWidget: GestureDetector(
        onTap: () {
          context.pop();
        },
        child: const LmuIcon(
          icon: LucideIcons.arrow_left,
          size: 28,
        ),
      ),
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
