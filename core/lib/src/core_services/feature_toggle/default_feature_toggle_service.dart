import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../api.dart';
import '../../logs/app_logger.dart';
import 'feature_flag.dart';
import 'feature_toggle_service.dart';

class DefaultFeatureToggleService extends FeatureToggleService {
  DefaultFeatureToggleService(this._apiClient, this._appVersion);

  final BaseApiClient _apiClient;
  final String _appVersion;

  final String _featureFlagCacheKey = 'feature_flags';

  final StreamController<List<FeatureFlag>> _featureToggleStreamController = StreamController.broadcast();

  List<FeatureFlag>? _featureFlags;

  Future<void> init() async => await _fetchFeatureFlags();

  @override
  Stream<List<FeatureFlag>> getFeatureFlagsStream() => _featureToggleStreamController.stream.distinct();

  @override
  bool isEnabled(String id, {bool defaultValue = false}) {
    if (_featureFlags == null) return defaultValue;

    final feature = _featureFlags!.firstWhere(
      (flag) => flag.id == id,
      orElse: () => FeatureFlag(id: id, isActive: defaultValue),
    );
    return feature.isActive;
  }

  @override
  bool get areFeatureFlagsLoaded => _featureFlags != null;

  @override
  List<FeatureFlag> get availableFeatures => _featureFlags ?? [];

  @override
  void reloadFeatures() async {
    AppLogger().logMessage('[DefaultFeatureToggleService]: Reloading feature flags...');
    await _fetchFeatureFlags();
  }

  Future<void> _loadFeatureFlagsFromCache() async {
    final prefs = await SharedPreferences.getInstance();

    final featureFlagsJson = prefs.getString(_featureFlagCacheKey);
    if (featureFlagsJson != null) {
      try {
        final List<dynamic> jsonList = List.from(json.decode(featureFlagsJson));
        _featureFlags = jsonList.map((json) => FeatureFlag.fromJson(json)).toList();
        _featureToggleStreamController.add(_featureFlags!);
      } catch (e) {
        AppLogger().logError('[DefaultFeatureToggleService]: Failed to parse cached feature flags. $e');
      }
    }
  }

  Future<void> _fetchFeatureFlags() async {
    try {
      final response = await _apiClient.get("/feature-flags?version=$_appVersion");

      final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
      _featureFlags = jsonList.map((json) => FeatureFlag.fromJson(json)).toList();
      AppLogger().logMessage('[DefaultFeatureToggleService]: Fetched feature flags: $_featureFlags');

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_featureFlagCacheKey, response.body);

      _featureToggleStreamController.add(_featureFlags!);
    } catch (e) {
      AppLogger().logError('[DefaultFeatureToggleService]: Failed to fetch feature flags. $e');
      await _loadFeatureFlagsFromCache();
    }
  }
}
