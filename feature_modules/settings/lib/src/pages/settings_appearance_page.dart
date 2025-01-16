import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../extensions/enum_naming_extensions.dart';

class SettingsApperancePage extends StatelessWidget {
  const SettingsApperancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = GetIt.I.get<ThemeProvider>();
    final localization = context.locals.settings;

    return LmuMasterAppBar(
      largeTitle: localization.appearance,
      leadingAction: LeadingAction.back,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(LmuSizes.size_16),
            child: ListenableBuilder(
              listenable: themeProvider,
              builder: (context, _) => LmuContentTile(
                content: ThemeMode.values
                    .map(
                      (themeMode) => LmuListItem.action(
                        title: themeMode.localizedName(localization),
                        actionType: LmuListItemAction.radio,
                        initialValue: themeProvider.themeMode == themeMode,
                        shouldChange: (_) => themeProvider.themeMode != themeMode,
                        onTap: () => themeProvider.setThemeMode(themeMode),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
