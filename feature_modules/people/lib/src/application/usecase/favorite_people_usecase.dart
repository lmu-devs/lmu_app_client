import 'package:flutter/foundation.dart';

import '../../infrastructure/secondary/data/storage/people_favorites_storage.dart';

class FavoritePeopleUsecase extends ChangeNotifier {
  FavoritePeopleUsecase(this._storage) {
    _load();
  }

  final PeopleFavoritesStorage _storage;
  final Set<int> _favoriteIds = {};
  final ValueNotifier<Set<int>> favoriteIdsNotifier = ValueNotifier<Set<int>>({});

  Set<int> get favoriteIds => _favoriteIds;

  bool isFavorite(int id) => _favoriteIds.contains(id);

  Future<void> toggleFavorite(int id) async {
    if (_favoriteIds.remove(id)) {
      await _storage.saveFavoriteIds(_favoriteIds.toList());
    } else {
      _favoriteIds.add(id);
      await _storage.saveFavoriteIds(_favoriteIds.toList());
    }
    favoriteIdsNotifier.value = Set.from(_favoriteIds);
    notifyListeners();
  }

  Future<void> _load() async {
    _favoriteIds
      ..clear()
      ..addAll(await _storage.getFavoriteIds());
    favoriteIdsNotifier.value = Set.from(_favoriteIds);
    notifyListeners();
  }
} 