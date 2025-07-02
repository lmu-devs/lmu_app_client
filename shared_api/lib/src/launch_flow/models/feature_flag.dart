abstract class FeatureFlag {
  const FeatureFlag();

  /// The unique identifier for the feature.
  String get id;

  /// Indicates whether the feature is active.
  bool get isActive;
}
