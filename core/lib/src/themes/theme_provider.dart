import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  // Constructor to load theme mode from shared preferences
  ThemeProvider() {
    _loadThemeMode();
  }
  // Initialize with system theme
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    // Save the theme mode to persistent storage
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', mode.toString());
  }

  Future<void> _loadThemeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString('themeMode') ?? ThemeMode.system.toString();
    if (themeModeString == ThemeMode.dark.toString()) {
      _themeMode = ThemeMode.dark;
    } else if (themeModeString == ThemeMode.light.toString()) {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }
}
