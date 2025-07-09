import 'package:flutter/foundation.dart';

import '../../domain/exception/people_generic_exception.dart';
import '../../domain/interface/people_repository_interface.dart';
import '../../domain/model/people.dart';

enum PeopleLoadState { initial, loading, loadingWithCache, success, error }

class GetPeopleUsecase extends ChangeNotifier {
  GetPeopleUsecase(this._repository);

  final PeopleRepositoryInterface _repository;

  PeopleLoadState _loadState = PeopleLoadState.initial;
  List<People> _data = [];

  PeopleLoadState get loadState => _loadState;
  List<People> get data => _data;

  List<People> get favoritePeople => _data.where((person) => person.isFavorite).toList();

  List<People> get nonFavoritePeople => _data.where((person) => !person.isFavorite).toList();

  Future<void> load() async {
    if (_loadState == PeopleLoadState.loading ||
        _loadState == PeopleLoadState.loadingWithCache ||
        _loadState == PeopleLoadState.success) {
      return;
    }

    final cached = await _repository.getCachedPeople();
    if (cached != null && cached.isNotEmpty) {
      _loadState = PeopleLoadState.loadingWithCache;
      _data = cached;
      notifyListeners();
    } else {
      _loadState = PeopleLoadState.loading;
      _data = [];
      notifyListeners();
    }

    try {
      final result = await _repository.getPeople();
      _loadState = PeopleLoadState.success;
      _data = result;
    } on PeopleGenericException {
      if (cached != null && cached.isNotEmpty) {
        _loadState = PeopleLoadState.success;
        _data = cached;
      } else {
        _loadState = PeopleLoadState.error;
        _data = [];
      }
    }

    notifyListeners();
  }

  /// Toggle favorite status of a person
  Future<void> toggleFavorite(int personId) async {
    try {
      await _repository.toggleFavorite(personId);
      
      // Update the local data to reflect the change immediately
      final personIndex = _data.indexWhere((person) => person.id == personId);
      if (personIndex != -1) {
        final person = _data[personIndex];
        _data[personIndex] = person.copyWith(isFavorite: !person.isFavorite);
        notifyListeners();
      }
    } catch (e) {
      // Handle error - could show toast or ignore for now
      // The error handling can be implemented based on requirements
    }
  }
}
