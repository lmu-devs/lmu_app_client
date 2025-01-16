import 'package:core/localizations.dart';
import 'package:flutter/material.dart';

extension ThemeModeLocalizer on ThemeMode {
  String localizedName(SettingsLocalizations localizations) {
    return switch (this) {
      ThemeMode.system => localizations.systemMode,
      ThemeMode.light => localizations.lightMode,
      ThemeMode.dark => localizations.darkMode,
    };
  }
}

extension LocaleLocalizer on Locale {
  String localizedName(SettingsLocalizations localizations) {
    switch (languageCode) {
      case 'en':
        return localizations.english;
      case 'de':
        return localizations.german;
      default:
        return languageCode;
    }
  }
}
