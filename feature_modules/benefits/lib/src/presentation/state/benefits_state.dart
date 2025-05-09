import 'package:flutter/foundation.dart';

import '../../application/usecases/get_benefits_usecase.dart';
import '../../application/usecases/get_cached_benefits_usecase.dart';
import '../../domain/models/benefit_category.dart';

enum BenefitsLoadState { initial, loading, success, error }

class BenefitsState {
  BenefitsState(this._getBenefitsUsecase, this._getCachedBenefitsUsecase);

  final GetBenefitsUsecase _getBenefitsUsecase;
  final GetCachedBenefitsUsecase _getCachedBenefitsUsecase;

  final ValueNotifier<BenefitsLoadState> _stateNotifier = ValueNotifier(BenefitsLoadState.initial);
  List<BenefitCategory> _benefitCategories = [];

  List<BenefitCategory> get benefitsCategories => _benefitCategories;
  ValueListenable<BenefitsLoadState> get state => _stateNotifier;

  BenefitCategory? selectedCategory;

  Future<void> getBenefits() async {
    if (_stateNotifier.value == BenefitsLoadState.loading || _stateNotifier.value == BenefitsLoadState.success) return;
    final cachedBenefits = await _getCachedBenefitsUsecase.call();
    if (cachedBenefits != null) {
      _benefitCategories = cachedBenefits;
    }

    _stateNotifier.value = BenefitsLoadState.loading;

    final benefits = await _getBenefitsUsecase.call();
    if (benefits == null) {
      _stateNotifier.value = BenefitsLoadState.error;
      return;
    }
    _benefitCategories = benefits;
    _stateNotifier.value = BenefitsLoadState.success;
  }
}
