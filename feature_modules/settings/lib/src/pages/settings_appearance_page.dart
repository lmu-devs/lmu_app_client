import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingsApperancePage extends StatelessWidget {
  const SettingsApperancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: context.colors.neutralColors.backgroundColors.base,
      appBar: LmuDefaultNavigationBar(
        title: "Erscheinungsbild",
        leadingWidget: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: const LmuIcon(
            icon: Icons.arrow_back,
            size: LmuSizes.large,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(LmuSizes.mediumLarge),
        child: ConentTile(
          content: [
            LmuListItem.action(
              title: "Automatisch",
              actionType: LmuListItemAction.radio,
              initialValue: themeProvider.themeMode == ThemeMode.system,
              onTap: () {
                themeProvider.setThemeMode(ThemeMode.system);
              },
            ),
            LmuListItem.action(
              title: "Hell",
              actionType: LmuListItemAction.radio,
              initialValue: themeProvider.themeMode == ThemeMode.light,
              onTap: () {
                themeProvider.setThemeMode(ThemeMode.light);
              },
            ),
            LmuListItem.action(
              title: "Dunkel",
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
