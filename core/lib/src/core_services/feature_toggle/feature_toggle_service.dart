import 'feature_flag.dart';

abstract class FeatureToggleService {
  /// Checks if a feature is enabled.
  ///
  /// Returns `true` if the feature is enabled, otherwise `false`.
  bool isEnabled(String id, {bool defaultValue = false});

  /// Gets the list of all available features.
  ///
  /// Returns a list of feature names.
  List<FeatureFlag> get availableFeatures;

  /// Gets a stream of available features, updates when features change.
  Stream<List<FeatureFlag>> getFeatureFlagsStream();

  bool get areFeatureFlagsLoaded;

  void reloadFeatures();
}
