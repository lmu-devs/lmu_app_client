import 'package:flutter/foundation.dart';

import '../../infrastructure/secondary/data/storage/lectures_storage.dart';

class FavoriteLecturesUsecase extends ChangeNotifier {
  FavoriteLecturesUsecase(this._storage) {
    _loadFavorites();
  }

  final LecturesStorage _storage;
  final Set<String> _favoriteIds = <String>{};
  final ValueNotifier<Set<String>> favoriteIdsNotifier = ValueNotifier<Set<String>>(<String>{});

  Set<String> get favoriteIds => _favoriteIds;

  bool isFavorite(String lectureId) => _favoriteIds.contains(lectureId);

  void toggleFavorite(String lectureId) {
    if (_favoriteIds.contains(lectureId)) {
      _favoriteIds.remove(lectureId);
    } else {
      _favoriteIds.add(lectureId);
    }
    _saveFavorites();
    favoriteIdsNotifier.value = Set.from(_favoriteIds);
    notifyListeners();
  }

  void addFavorite(String lectureId) {
    if (!_favoriteIds.contains(lectureId)) {
      _favoriteIds.add(lectureId);
      _saveFavorites();
      favoriteIdsNotifier.value = Set.from(_favoriteIds);
      notifyListeners();
    }
  }

  void removeFavorite(String lectureId) {
    if (_favoriteIds.contains(lectureId)) {
      _favoriteIds.remove(lectureId);
      _saveFavorites();
      favoriteIdsNotifier.value = Set.from(_favoriteIds);
      notifyListeners();
    }
  }

  Future<void> _loadFavorites() async {
    try {
      _favoriteIds.clear();
      _favoriteIds.addAll(await _storage.getFavoriteIds());
      favoriteIdsNotifier.value = Set.from(_favoriteIds);
    } catch (e) {
      // Handle error silently, start with empty set
      favoriteIdsNotifier.value = <String>{};
    }
  }

  Future<void> _saveFavorites() async {
    try {
      await _storage.saveFavoriteIds(_favoriteIds);
    } catch (e) {
      // Handle error silently
    }
  }

  @override
  void dispose() {
    favoriteIdsNotifier.dispose();
    super.dispose();
  }
}
