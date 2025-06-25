import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

import '../../../core_services.dart';

class AnalyticsUserPreferenceService {
  AnalyticsUserPreferenceService._();

  late final SharedPreferences _prefs;
  final ValueNotifier<bool> isAnalyticsEnabled = ValueNotifier(true);

  static const String _analyticsKey = 'analytics_collection_key';

  static Future<AnalyticsUserPreferenceService> create() async {
    final service = AnalyticsUserPreferenceService._();
    await service._init();
    return service;
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();

    final currentPref = _prefs.getBool(_analyticsKey) ?? true;
    isAnalyticsEnabled.value = currentPref;

    _applyAnalyticsSetting(currentPref);
  }

  Future<void> toggleAnalytics(bool isEnabled) async {
    isAnalyticsEnabled.value = isEnabled;
    await _prefs.setBool(_analyticsKey, isEnabled);
    _applyAnalyticsSetting(isEnabled);
  }

  void _applyAnalyticsSetting(bool isEnabled) {
    final analyticsClient = GetIt.I<AnalyticsClient>();
    analyticsClient.toggleAnalyticsCollection(isEnabled: isEnabled);
  }
}
