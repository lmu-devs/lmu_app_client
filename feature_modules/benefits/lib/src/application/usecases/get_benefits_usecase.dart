import 'package:flutter/foundation.dart';

import '../../domain/exception/benefits_generic_exception.dart';
import '../../domain/interface/benefits_repository_interface.dart';
import '../../domain/models/benefit_category.dart';

enum BenefitsLoadState { initial, loading, loadingWithCache, success, error }

class GetBenefitsUsecase extends ChangeNotifier {
  GetBenefitsUsecase(this._repository);

  final BenefitsRepositoryInterface _repository;

  BenefitsLoadState _loadState = BenefitsLoadState.initial;
  List<BenefitCategory> _benefitCategories = [];

  BenefitsLoadState get loadState => _loadState;
  List<BenefitCategory> get benefitCategories => _benefitCategories;

  Future<void> load() async {
    if (_loadState == BenefitsLoadState.loading ||
        _loadState == BenefitsLoadState.loadingWithCache ||
        _loadState == BenefitsLoadState.success) {
      return;
    }

    final cachedBenefits = await _repository.getCachedBenefits();
    if (cachedBenefits != null) {
      _loadState = BenefitsLoadState.loadingWithCache;
      _benefitCategories = cachedBenefits;
      notifyListeners();
    } else {
      _loadState = BenefitsLoadState.loading;
      _benefitCategories = [];
      notifyListeners();
    }

    try {
      final benefits = await _repository.getBenefits();
      _loadState = BenefitsLoadState.success;
      _benefitCategories = benefits;
    } on BenefitsGenericException {
      if (cachedBenefits != null) {
        _loadState = BenefitsLoadState.success;
        _benefitCategories = cachedBenefits;
      } else {
        _loadState = BenefitsLoadState.error;
        _benefitCategories = [];
      }
    }

    notifyListeners();
  }
}
