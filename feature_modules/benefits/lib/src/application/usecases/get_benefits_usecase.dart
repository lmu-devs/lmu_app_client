import 'package:core/utils.dart';
import 'package:flutter/foundation.dart';

import '../../domain/interface/benefits_repository_interface.dart';
import '../../domain/models/benefit_category.dart';

class GetBenefitsUsecase extends ChangeNotifier {
  GetBenefitsUsecase(this._repository);

  final BenefitsRepositoryInterface _repository;

  LoadState _loadState = LoadState.initial;
  List<BenefitCategory> _benefitCategories = [];

  LoadState get loadState => _loadState;
  List<BenefitCategory> get benefitCategories => _benefitCategories;

  Future<void> load() async {
    if (_loadState.isLoadingOrSuccess) return;

    final cachedBenefits = await _repository.getCachedBenefits();
    if (cachedBenefits != null) {
      _loadState = LoadState.loadingWithCache;
      _benefitCategories = cachedBenefits;
      notifyListeners();
    } else {
      _loadState = LoadState.loading;
      _benefitCategories = [];
      notifyListeners();
    }

    try {
      final benefits = await _repository.getBenefits();
      _loadState = LoadState.success;
      _benefitCategories = benefits;
    } catch (e) {
      if (cachedBenefits != null) {
        _loadState = LoadState.success;
        _benefitCategories = cachedBenefits;
      } else {
        if (e is NoNetworkException) {
          _loadState = LoadState.noNetworkError;
        } else {
          _loadState = LoadState.genericError;
        }
        _benefitCategories = [];
      }
    }

    notifyListeners();
  }
}
