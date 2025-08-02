import 'package:flutter/foundation.dart';

import '../../infrastructure/secondary/data/storage/people_recent_searches_storage.dart';
import '../../domain/model/people.dart';

class RecentSearchesUsecase extends ChangeNotifier {
  RecentSearchesUsecase(this._storage) {
    _load();
  }

  final PeopleRecentSearchesStorage _storage;
  final List<People> _recentSearches = [];
  final ValueNotifier<List<People>> recentSearchesNotifier = ValueNotifier<List<People>>([]);

  List<People> get recentSearches => _recentSearches;

  Future<void> addRecentSearch(People person) async {
    _recentSearches.removeWhere((p) => p.id == person.id);
    

    _recentSearches.insert(0, person);
    
    if (_recentSearches.length > 10) {
      _recentSearches.removeRange(10, _recentSearches.length);
    }
    
    await _storage.saveRecentSearches(_recentSearches);
    recentSearchesNotifier.value = List.from(_recentSearches);
    notifyListeners();
  }

  Future<void> clearRecentSearches() async {
    _recentSearches.clear();
    await _storage.clearRecentSearches();
    recentSearchesNotifier.value = [];
    notifyListeners();
  }

  Future<void> _load() async {
    _recentSearches.clear();
    _recentSearches.addAll(await _storage.getRecentSearches());
    recentSearchesNotifier.value = List.from(_recentSearches);
    notifyListeners();
  }
} 