import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import '../../../core_services.dart';

enum AnalyticsPreference {
  enabled,
  disabled,
  none,
}

extension AnalyticsPreferenceExtension on AnalyticsPreference {
  static AnalyticsPreference fromString(String preference) =>
      switch (preference) {
        'enabled' => AnalyticsPreference.enabled,
        'disabled' => AnalyticsPreference.disabled,
        'none' => AnalyticsPreference.none,
        _ => throw ArgumentError('Invalid AnalyticsPreference: $preference'),
      };
}

class AnalyticsUserPreferenceService {
  AnalyticsUserPreferenceService();

  late final SharedPreferences _prefs;
  final ValueNotifier<AnalyticsPreference> analyticsPreference = ValueNotifier(AnalyticsPreference.none);

  static const String _analyticsKey = 'analytics_collection_key';

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();

    final storedPreference = _prefs.getString(_analyticsKey) ?? AnalyticsPreference.none.name;
    final preference = AnalyticsPreferenceExtension.fromString(storedPreference);
    await toggleAnalytics(preference);
  }

  Future<void> toggleAnalytics(AnalyticsPreference preference) async {
    analyticsPreference.value = preference;
    await _prefs.setString(_analyticsKey, preference.name);

    if (preference == AnalyticsPreference.enabled) {
      _applyAnalyticsSetting(true);
    } else {
      _applyAnalyticsSetting(false);
    }
  }

  void _applyAnalyticsSetting(bool isEnabled) {
    final analyticsClient = GetIt.I<AnalyticsClient>();
    analyticsClient.toggleAnalyticsCollection(isEnabled: isEnabled);
  }
}
