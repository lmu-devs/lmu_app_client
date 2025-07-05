import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import '../../../core_services.dart';

class AnalyticsUserPreferenceService {
  AnalyticsUserPreferenceService();

  late final SharedPreferences _prefs;
  final ValueNotifier<bool> isAnalyticsEnabled = ValueNotifier(false);

  static const String _analyticsKey = 'analytics_collection_key';

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();

    final currentPref = _prefs.getBool(_analyticsKey) ?? false;
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
