import 'package:flutter/foundation.dart';

import '../../infrastructure/secondary/data/storage/lectures_favorites_storage.dart';

class FavoriteLecturesUsecase extends ChangeNotifier {
  FavoriteLecturesUsecase(this._storage) {
    _load();
  }

  final LecturesFavoritesStorage _storage;
  final Set<String> _favoriteIds = {};
  final ValueNotifier<Set<String>> favoriteIdsNotifier = ValueNotifier<Set<String>>({});

  Set<String> get favoriteIds => _favoriteIds;

  bool isFavorite(String id) => _favoriteIds.contains(id);

  Future<void> toggleFavorite(String id) async {
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
