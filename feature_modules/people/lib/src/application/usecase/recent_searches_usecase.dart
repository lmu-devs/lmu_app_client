import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
import '../../infrastructure/secondary/data/storage/people_recent_searches_storage.dart';
import '../../domain/model/people.dart';
import 'get_people_usecase.dart';
import 'package:collection/collection.dart';


class RecentSearchesUsecase extends ChangeNotifier {
  RecentSearchesUsecase(this._storage, this._getPeopleUsecase) {
    _load();
  }

  final PeopleRecentSearchesStorage _storage;
  final GetPeopleUsecase _getPeopleUsecase;
  final List<int> _recentSearchIds = [];
  final ValueNotifier<List<People>> recentSearchesNotifier = ValueNotifier<List<People>>([]);

  List<People> get recentSearches {
    final allPeople = _getPeopleUsecase.data;
    return _recentSearchIds
        .map((id) => allPeople.where((person) => person.id == id).firstOrNull)
        .whereType<People>()
        .toList();
  }

  Future<void> addRecentSearch(People person) async {
    _updateRecentSearchIds(person.id);
    await _storage.saveRecentSearches(_recentSearchIds.map((e) => e.toString()).toList());
    _updateRecentSearchesNotifier();
    notifyListeners();
  }

  Future<void> clearRecentSearches() async {
    _recentSearchIds.clear();
    await _storage.clearRecentSearches();
    recentSearchesNotifier.value = [];
    notifyListeners();
  }

  Future<void> _load() async {
    _recentSearchIds.clear();
    final stringIds = await _storage.getRecentSearches();
    _recentSearchIds.addAll(stringIds.map((s) => int.tryParse(s)).whereType<int>());
    _updateRecentSearchesNotifier();
    notifyListeners();
  }

  void _updateRecentSearchIds(int id) {
    _recentSearchIds.remove(id);
    _recentSearchIds.insert(0, id);

    if (_recentSearchIds.length > 10) {
      _recentSearchIds.removeRange(10, _recentSearchIds.length);
    }
  }

  void _updateRecentSearchesNotifier() {
    recentSearchesNotifier.value = recentSearches;
  }
}
