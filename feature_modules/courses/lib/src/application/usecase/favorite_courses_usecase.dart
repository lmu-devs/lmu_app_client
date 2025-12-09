import 'package:core/themes.dart';
import 'package:flutter/foundation.dart';

import '../../infrastructure/secondary/data/storage/courses_favorites_storage.dart';

class FavoriteCoursesUsecase extends ChangeNotifier {
  FavoriteCoursesUsecase(this._storage) {
    _load();
  }

  final CoursesFavoritesStorage _storage;
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
    LmuVibrations.secondary();
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
