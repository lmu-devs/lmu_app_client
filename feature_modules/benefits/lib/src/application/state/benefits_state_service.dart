import 'package:flutter/foundation.dart';

import '../../domain/models/benefit_category.dart';
import '../usecases/get_benefits_usecase.dart';
import '../usecases/get_cached_benefits_usecase.dart';

enum BenefitsLoadState { initial, loading, loadingWithCache, success, error }

typedef BenefitsState = ({BenefitsLoadState loadState, List<BenefitCategory> benefitCategories});

class BenefitsStateService {
  BenefitsStateService(this._getBenefitsUsecase, this._getCachedBenefitsUsecase);

  final GetBenefitsUsecase _getBenefitsUsecase;
  final GetCachedBenefitsUsecase _getCachedBenefitsUsecase;

  final ValueNotifier<BenefitsState> _stateNotifier = ValueNotifier<BenefitsState>(
    (loadState: BenefitsLoadState.initial, benefitCategories: []),
  );

  ValueListenable<BenefitsState> get state => _stateNotifier;

  BenefitCategory? selectedCategory;

  Future<void> getBenefits() async {
    final loadState = _stateNotifier.value.loadState;
    if (loadState == BenefitsLoadState.loading ||
        loadState == BenefitsLoadState.loadingWithCache ||
        loadState == BenefitsLoadState.success) {
      return;
    }

    final cachedBenefits = await _getCachedBenefitsUsecase.call();
    if (cachedBenefits != null) {
      _stateNotifier.value = (loadState: BenefitsLoadState.loadingWithCache, benefitCategories: cachedBenefits);
    } else {
      _stateNotifier.value = (loadState: BenefitsLoadState.loading, benefitCategories: []);
    }

    final benefits = await _getBenefitsUsecase.call();
    if (benefits == null && cachedBenefits == null) {
      _stateNotifier.value = (loadState: BenefitsLoadState.error, benefitCategories: []);
      return;
    }
    _stateNotifier.value = (loadState: BenefitsLoadState.success, benefitCategories: benefits ?? cachedBenefits!);
  }
}
