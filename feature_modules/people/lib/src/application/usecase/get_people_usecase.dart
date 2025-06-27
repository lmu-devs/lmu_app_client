import 'package:flutter/foundation.dart';

import '../../domain/exception/people_generic_exception.dart';
import '../../domain/interface/people_repository_interface.dart';
import '../../domain/model/people.dart';

enum PeopleLoadState { initial, loading, loadingWithCache, success, error }

class GetPeopleUsecase extends ChangeNotifier {
  GetPeopleUsecase(this._repository);

  final PeopleRepositoryInterface _repository;

  PeopleLoadState _loadState = PeopleLoadState.initial;
  People? _data;

  PeopleLoadState get loadState => _loadState;
  People? get data => _data;

  Future<void> load() async {
    if (_loadState == PeopleLoadState.loading ||
        _loadState == PeopleLoadState.loadingWithCache ||
        _loadState == PeopleLoadState.success) {
      return;
    }

    final cached = await _repository.getCachedPeople();
    if (cached != null) {
      _loadState = PeopleLoadState.loadingWithCache;
      _data = cached;
      notifyListeners();
    } else {
      _loadState = PeopleLoadState.loading;
      _data = null;
      notifyListeners();
    }

    try {
      final result = await _repository.getPeople();
      _loadState = PeopleLoadState.success;
      _data = result;
    } on PeopleGenericException {
      if (cached != null) {
        _loadState = PeopleLoadState.success;
        _data = cached;
      } else {
        _loadState = PeopleLoadState.error;
        _data = null;
      }
    }

    notifyListeners();
  }
}
