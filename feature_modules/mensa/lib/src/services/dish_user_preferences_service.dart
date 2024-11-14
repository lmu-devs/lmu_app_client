import 'package:flutter/foundation.dart';

import '../repository/api/models/user_preferences/user_preferences.dart';
import '../repository/dish_repository.dart';

class DishUserPreferencesService {
  DishUserPreferencesService({
    required DishRepository dishRepository,
  }) : _dishRepository = dishRepository;

  Future init() {
    return Future.wait([
      getSortOption(),
      getFavoriteDishIds(),
    ]);
  }

  final DishRepository _dishRepository;

  var _initialSortOption = SortOption.alphabetically;
  SortOption get initialSortOption => _initialSortOption;

  final _favoriteDishIdsNotifier = ValueNotifier<List<String>>([]);
  ValueNotifier<List<String>> get favoriteDishIdsNotifier => _favoriteDishIdsNotifier;

  Future<void> getFavoriteDishIds() async {
    final favoriteDishIds = await _dishRepository.getFavoriteDishIds();

    if (favoriteDishIds != null) {
      _favoriteDishIdsNotifier.value = favoriteDishIds;
    }
  }

  Future<void> toggleFavoriteDishId(int dishId) async {
    final favoriteDishIds = List<String>.from(_favoriteDishIdsNotifier.value);

    if (favoriteDishIds.contains(dishId)) {
      favoriteDishIds.remove(dishId);
    } else {
      favoriteDishIds.insert(0, dishId.toString());
    }

    await _updateFavoriteDishIds(favoriteDishIds);
  }

  Future<void> _updateFavoriteDishIds(List<String> favoriteDishIds) async {
    _favoriteDishIdsNotifier.value = favoriteDishIds;
    await _dishRepository.updateFavoriteDishIds(favoriteDishIds);
  }

  Future<void> getSortOption() async {
    final loadedSortOption = await _dishRepository.getSortOption();

    if (loadedSortOption != null) {
      _initialSortOption = loadedSortOption;
    }
  }

  Future<void> updateSortOption(SortOption sortOption) async {
    await _dishRepository.setSortOption(sortOption);
  }
}
