import 'package:core/logging.dart';
import 'package:core/themes.dart';
import 'package:flutter/foundation.dart';

import '../../infrastructure/secondary/data/storage/courses_favorites_storage.dart';

class FavoriteCoursesUsecase extends ChangeNotifier {
  FavoriteCoursesUsecase(this._storage) {
    _load();
  }

  final _appLogger = AppLogger();
  final CoursesFavoritesStorage _storage;
  final Map<int, List<int>> _favoritesMap = {};
  final Set<int> _flatFavoritesSet = {};
  final ValueNotifier<Map<int, List<int>>> favoritesMapNotifier =
      ValueNotifier({});

  Set<int> get flatFavoritesSet => _flatFavoritesSet;

  bool isFavorite(int courseId) => _flatFavoritesSet.contains(courseId);

  Future<void> toggleFavorite(int facultyId, int courseId) async {
    List<int> facultyFavorites = _favoritesMap[facultyId] ?? [];

    if (facultyFavorites.contains(courseId)) {
      facultyFavorites.remove(courseId);
      _flatFavoritesSet.remove(courseId);

      _appLogger.logMessage("Course $courseId removed from favorites for faculty $facultyId");

      if (facultyFavorites.isEmpty) {
        _favoritesMap.remove(facultyId);
      } else {
        _favoritesMap[facultyId] = facultyFavorites;
      }
    } else {
      facultyFavorites.add(courseId);
      _favoritesMap[facultyId] = facultyFavorites;
      _flatFavoritesSet.add(courseId);

      _appLogger.logMessage("Course $courseId added to favorites for faculty $facultyId");
    }

    favoritesMapNotifier.value = Map.from(_favoritesMap);
    notifyListeners();
    LmuVibrations.secondary();

    await _storage.saveFavoritesMap(_favoritesMap);
  }

  Future<void> updateFavoriteCoursesOrder(
      int facultyId, List<int> newOrder) async {
    _favoritesMap[facultyId] = newOrder;

    favoritesMapNotifier.value = Map.from(_favoritesMap);
    notifyListeners();

    await _storage.saveFavoritesMap(_favoritesMap);
  }

  Future<void> _load() async {
    final loadedMap = await _storage.getFavoritesMap();

    _favoritesMap.clear();
    _favoritesMap.addAll(loadedMap);

    _flatFavoritesSet.clear();
    for (final list in _favoritesMap.values) {
      _flatFavoritesSet.addAll(list);
    }

    favoritesMapNotifier.value = Map.from(_favoritesMap);
    notifyListeners();
  }
}
