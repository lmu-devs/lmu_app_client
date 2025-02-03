import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePreferencesService {
  final _tutotialKey = 'tuitionPayed';

  HomePreferencesService() {
    init();
  }

  final ValueNotifier<bool> _tuitionPayed = ValueNotifier<bool>(false);
  ValueNotifier<bool> get tuitionPayed => _tuitionPayed;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _tuitionPayed.value = prefs.getBool(_tutotialKey) ?? false;
  }

  Future<void> setTuitionPayed(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_tutotialKey, value);
    _tuitionPayed.value = value;
  }
}
