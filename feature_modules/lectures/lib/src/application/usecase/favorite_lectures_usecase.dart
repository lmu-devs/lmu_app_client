import 'package:flutter/foundation.dart';

import '../../domain/base/base_usecase.dart';
import '../../infrastructure/secondary/data/storage/lectures_storage.dart';

class FavoriteLecturesUsecase extends BaseUsecase {
  FavoriteLecturesUsecase(this._storage) {
    _loadFavorites();
  }

  final LecturesStorage _storage;
  final Set<String> _favoriteIds = <String>{};
  final ValueNotifier<Set<String>> favoriteIdsNotifier = ValueNotifier<Set<String>>(<String>{});

  bool _isDisposed = false;

  Set<String> get favoriteIds => _favoriteIds;

  bool isFavorite(String lectureId) {
    if (lectureId.isEmpty) return false;
    return _favoriteIds.contains(lectureId);
  }

  void toggleFavorite(String lectureId) {
    if (_isDisposed || lectureId.isEmpty) {
      if (lectureId.isEmpty) {
        debugPrint('Cannot toggle favorite: empty lecture ID');
      }
      return;
    }

    if (_favoriteIds.contains(lectureId)) {
      _favoriteIds.remove(lectureId);
    } else {
      _favoriteIds.add(lectureId);
    }
    _saveFavorites();
    favoriteIdsNotifier.value = Set.from(_favoriteIds);
  }

  void addFavorite(String lectureId) {
    if (_isDisposed || lectureId.isEmpty) {
      if (lectureId.isEmpty) {
        debugPrint('Cannot add favorite: empty lecture ID');
      }
      return;
    }

    if (!_favoriteIds.contains(lectureId)) {
      _favoriteIds.add(lectureId);
      _saveFavorites();
      favoriteIdsNotifier.value = Set.from(_favoriteIds);
    }
  }

  void removeFavorite(String lectureId) {
    if (_isDisposed || lectureId.isEmpty) {
      if (lectureId.isEmpty) {
        debugPrint('Cannot remove favorite: empty lecture ID');
      }
      return;
    }

    if (_favoriteIds.contains(lectureId)) {
      _favoriteIds.remove(lectureId);
      _saveFavorites();
      favoriteIdsNotifier.value = Set.from(_favoriteIds);
    }
  }

  Future<void> _loadFavorites() async {
    if (_isDisposed) return;

    try {
      _favoriteIds.clear();
      _favoriteIds.addAll(await _storage.getFavoriteIds());
      if (!_isDisposed) {
        favoriteIdsNotifier.value = Set.from(_favoriteIds);
      }
    } catch (e) {
      // Handle error gracefully, start with empty set
      debugPrint('Failed to load favorites: $e');
      if (!_isDisposed) {
        favoriteIdsNotifier.value = <String>{};
      }
    }
  }

  Future<void> _saveFavorites() async {
    if (_isDisposed) return;

    try {
      await _storage.saveFavoriteIds(_favoriteIds);
    } catch (e) {
      // Handle error gracefully - favorites will be lost on app restart
      debugPrint('Failed to save favorites: $e');
    }
  }

  @override
  void addListenersToNotifiers(VoidCallback listener) {
    favoriteIdsNotifier.addListener(listener);
  }

  @override
  void removeListenersFromNotifiers(VoidCallback listener) {
    favoriteIdsNotifier.removeListener(listener);
  }

  @override
  void disposeNotifiers() {
    favoriteIdsNotifier.dispose();
  }
}
