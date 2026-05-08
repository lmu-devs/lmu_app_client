import 'package:shared_api/launch_flow.dart';

class FeatureFlagImpl implements FeatureFlag {
  const FeatureFlagImpl({
    required this.id,
    required this.isActive,
  });

  @override
  final String id;

  @override
  final bool isActive;
}
