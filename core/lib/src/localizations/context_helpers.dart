import 'package:core/src/localizations/generated/app_localizations.dart';
import 'package:core/src/localizations/generated/explore_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/canteen_localizations.dart';
import 'generated/settings_localizations.dart';

extension LocalizationExtension on BuildContext {
  LmuLocalizations get locals => LmuLocalizations(this);
}

class LmuLocalizations {
  final BuildContext context;

  LmuLocalizations(this.context);

  AppLocalizations get app => AppLocalizations.of(context)!;
  CanteenLocalizations get canteen => CanteenLocalizations.of(context)!;
  ExploreLocalizations get explore => ExploreLocalizations.of(context)!;
  SettingsLocalizations get settings => SettingsLocalizations.of(context)!;

  static List<LocalizationsDelegate> get localizationsDelegates => [
        CanteenLocalizations.delegate,
        SettingsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];

  static List<Locale> get supportedLocales => const [
        Locale('en'),
        Locale('de'),
        // Add other supported locales
      ];
}
