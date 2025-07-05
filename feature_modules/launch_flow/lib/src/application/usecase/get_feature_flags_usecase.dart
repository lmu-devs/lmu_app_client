import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:shared_api/launch_flow.dart';

import '../../domain/error/app_update_required_error.dart';
import '../../domain/interface/feature_toggle_repository_interface.dart';

class GetFeatureFlagsUsecase extends ChangeNotifier {
  GetFeatureFlagsUsecase(this._repository);

  final FeatureToggleRepositoryInterface _repository;
  List<FeatureFlag> _featureFlags = [];

  List<FeatureFlag> get featureFlags => _featureFlags;

  Future<bool> loadFeatureFlags() async {
    try {
      final flags = await _repository.getFeatureFlags();
      _featureFlags = flags;
      notifyListeners();
      return false;
    } catch (e) {
      if (e is AppUpdateRequiredError) return true;

      return false;
    }
  }
}
