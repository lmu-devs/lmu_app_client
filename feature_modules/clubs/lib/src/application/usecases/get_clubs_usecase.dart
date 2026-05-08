import 'package:core/utils.dart';
import 'package:flutter/foundation.dart';

import '../../domain/interface/clubs_repository_interface.dart';
import '../../domain/models/club_category.dart';

class GetClubsUsecase extends ChangeNotifier {
  GetClubsUsecase(this._repository);

  final ClubsRepositoryInterface _repository;

  LoadState _loadState = LoadState.initial;
  List<ClubCategory> _clubCategories = [];

  LoadState get loadState => _loadState;
  List<ClubCategory> get clubCategories => _clubCategories;

  Future<void> load() async {
    if (_loadState.isLoadingOrSuccess) return;

    final cachedClubs = await _repository.getCachedClubs();
    if (cachedClubs != null) {
      _loadState = LoadState.loadingWithCache;
      _clubCategories = cachedClubs;
      notifyListeners();
    } else {
      _loadState = LoadState.loading;
      _clubCategories = [];
      notifyListeners();
    }

    try {
      final clubs = await _repository.getClubs();
      _loadState = LoadState.success;
      _clubCategories = clubs;
    } catch (e) {
      if (cachedClubs != null) {
        _loadState = LoadState.success;
        _clubCategories = cachedClubs;
      } else {
        if (e is NoNetworkException) {
          _loadState = LoadState.noNetworkError;
        } else {
          _loadState = LoadState.genericError;
        }
        _clubCategories = [];
      }
    }

    notifyListeners();
  }
}
