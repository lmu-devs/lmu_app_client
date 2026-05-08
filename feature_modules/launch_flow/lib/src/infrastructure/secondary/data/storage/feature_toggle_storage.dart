import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../dto/feature_flag_dto.dart';

class FeatureToggleStorage {
  final String _featureFlagCacheKey = 'feature_flags';

  Future<List<FeatureFlagDto>?> getFeatureFlags() async {
    final prefs = await SharedPreferences.getInstance();

    final featureFlagsJson = prefs.getString(_featureFlagCacheKey);
    if (featureFlagsJson == null) return null;

    try {
      final List<dynamic> jsonList = List.from(json.decode(featureFlagsJson));
      return jsonList.map((json) => FeatureFlagDto.fromJson(json)).toList();
    } catch (e) {
      return null;
    }
  }

  Future<void> saveFeatureFlags(List<FeatureFlagDto> featureFlags) async {
    final prefs = await SharedPreferences.getInstance();
    final featureFlagsJson = json.encode(featureFlags.map((flag) => flag.toJson()).toList());
    await prefs.setString(_featureFlagCacheKey, featureFlagsJson);
  }
}
