import 'package:shared_api/launch_flow.dart';

import '../../../application/usecase/get_feature_flags_usecase.dart';
import '../../../domain/model/feature_flag_impl.dart';

class FeatureToggleApiImpl extends FeatureToggleApi {
  FeatureToggleApiImpl(this._getFeatureFlagsUsecase);

  final GetFeatureFlagsUsecase _getFeatureFlagsUsecase;

  @override
  List<FeatureFlag> get availableFeatures => _getFeatureFlagsUsecase.featureFlags;

  @override
  bool isEnabled(String id, {bool defaultValue = false}) {
    final feature = _getFeatureFlagsUsecase.featureFlags.firstWhere(
      (flag) => flag.id == id,
      orElse: () => FeatureFlagImpl(id: id, isActive: defaultValue),
    );
    return feature.isActive;
  }
}
