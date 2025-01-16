import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../extensions/enum_naming_extensions.dart';

class SettingsLanguagePage extends StatelessWidget {
  const SettingsLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = GetIt.I.get<LanguageProvider>();
    final localization = context.locals.settings;

    return LmuMasterAppBar(
      largeTitle: localization.language,
      leadingAction: LeadingAction.back,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(LmuSizes.size_16),
            child: ListenableBuilder(
              listenable: languageProvider,
              builder: (context, child) {
                return LmuContentTile(
                  content: [
                    LmuListItem.action(
                      title: localization.systemMode,
                      actionType: LmuListItemAction.radio,
                      initialValue: languageProvider.isAutomatic == true,
                      shouldChange: (_) => languageProvider.isAutomatic == false,
                      onTap: () => languageProvider.setAutomaticLocale(),
                    ),
                    ...LmuLocalizations.supportedLocales.map((locale) {
                      return LmuListItem.action(
                        title: locale.localizedName(localization),
                        actionType: LmuListItemAction.radio,
                        initialValue: languageProvider.locale == locale && !languageProvider.isAutomatic,
                        shouldChange: (_) => languageProvider.locale != locale || languageProvider.isAutomatic,
                        onTap: () => languageProvider.setCustomLocale(locale),
                      );
                    }),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
