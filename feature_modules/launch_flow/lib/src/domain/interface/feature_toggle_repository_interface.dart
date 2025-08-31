import 'package:shared_api/launch_flow.dart';

abstract class FeatureToggleRepositoryInterface {
  Future<List<FeatureFlag>> getFeatureFlags();
}
