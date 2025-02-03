import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../localizations.dart';

class LanguageProvider with ChangeNotifier {
  Future<void> init() async {
    await _loadAppLocale();
  }

  Locale _locale = LmuLocalizations.supportedLocales.first;
  bool _isAutomatic = true;
  Locale get locale => _locale;
  bool get isAutomatic => _isAutomatic;

  Future<void> setAutomaticLocale() async {
    _locale = Locale(PlatformDispatcher.instance.locale.languageCode);
    _isAutomatic = true;
    notifyListeners();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('appLocale', 'auto');
  }

  Future<void> setCustomLocale(Locale locale) async {
    _locale = locale;
    _isAutomatic = false;
    notifyListeners();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('appLocale', locale.languageCode);
  }

  Future<void> _loadAppLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final localeString = prefs.getString('appLocale') ?? "auto";
    if (localeString == 'auto') {
      _isAutomatic = true;
      _locale = PlatformDispatcher.instance.locale;
    } else {
      _isAutomatic = false;
      _locale = Locale(localeString);
    }

    notifyListeners();
  }
}
