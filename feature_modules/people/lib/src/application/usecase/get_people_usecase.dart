import 'package:flutter/foundation.dart';

import '../../domain/exception/people_generic_exception.dart';
import '../../domain/interface/people_repository_interface.dart';
import '../../domain/model/people.dart';

enum PeopleLoadState { initial, loading, success, error }

class GetPeopleUsecase extends ChangeNotifier {
  GetPeopleUsecase(this._repository);

  final PeopleRepositoryInterface _repository;

  PeopleLoadState _loadState = PeopleLoadState.initial;
  List<People> _data = [];

  PeopleLoadState get loadState => _loadState;
  List<People> get data => _data;

  Future<void> load() async {
    if (_loadState == PeopleLoadState.loading ||
        _loadState == PeopleLoadState.success) {
      return;
    }

    _loadState = PeopleLoadState.loading;
    _data = [];
    notifyListeners();

    try {
      final result = await _repository.getPeople();
      _loadState = PeopleLoadState.success;
      _data = result;
    } on PeopleGenericException {
      _loadState = PeopleLoadState.error;
      _data = [];
    }

    notifyListeners();
  }
}
