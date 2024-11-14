import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'api/mensa_api_client.dart';
import 'api/models/mensa_menu_week_model.dart';
import 'api/models/dish_model.dart';
import 'api/models/taste_profile/taste_profile.dart';
import 'api/models/user_preferences/sort_option.dart';

abstract class DishRepository {
  // Future<List<DishModel>> getDishModels();

  Future<List<String>?> getFavoriteDishIds();

  Future<void> updateFavoriteDishIds(List<String> favoriteDishIds);

  Future<List<MensaMenuWeekModel>> getMensaMenusForSpecificWeek(String canteenId, int year, String week, bool liked);


  Future<SortOption?> getSortOption();

  Future<void> setSortOption(SortOption dishUserPreferences);
}

class ConnectedDishRepository implements DishRepository {
  ConnectedDishRepository({
    required this.mensaApiClient,
  });

  final MensaApiClient mensaApiClient;

  static const String _dishModelsCacheKey = 'dish_models_cache_key';
  static const String _dishModelCacheDateKey = 'dish_models_cache_date_key';
  static const Duration _dishModelsCacheDuration = Duration(seconds: 30);

  static const String _favoriteDishIdsKey = 'favorite_dish_ids_key';

  static const String _pasteProfileSelectionsKey = 'taste_profile_selections_key';

  static const String _dishSortOptionKey = 'dish_user_preferences';

  // @override
  // Future<List<DishModel>> getDishModels({bool forceRefresh = false}) async {
  //   final prefs = await SharedPreferences.getInstance();

  //   final cachedData = prefs.getString(_dishModelsCacheKey);
  //   final cachedTime = prefs.getString(_dishModelCacheDateKey);
  //   final cachedDateTime = cachedTime != null ? DateTime.parse(cachedTime) : null;
  //   final cachedTimeExceeded =
  //       cachedDateTime != null && DateTime.now().difference(cachedDateTime) > _dishModelsCacheDuration;

  //   if (cachedData != null && !cachedTimeExceeded && !forceRefresh) {
  //     final jsonList = json.decode(cachedData) as List<dynamic>;
  //     return jsonList.map((json) => DishModel.fromJson(json as Map<String, dynamic>)).toList();
  //   }

  //   try {
  //     final dishModels = await mensaApiClient.getDishModels();
  //     final jsonResponse = json.encode(dishModels.map((dish) => dish.toJson()).toList());
  //     await prefs.setString(_dishModelsCacheKey, jsonResponse);
  //     await prefs.setString(_dishModelCacheDateKey, DateTime.now().toIso8601String());

  //     return dishModels;
  //   } catch (e) {
  //     if (cachedData != null) {
  //       final jsonList = json.decode(cachedData) as List<dynamic>;
  //       return jsonList.map((json) => DishModel.fromJson(json as Map<String, dynamic>)).toList();
  //     }
  //     rethrow;
  //   }
  // }

  /// Cache storing missing for now
  @override
  Future<List<MensaMenuWeekModel>> getMensaMenusForSpecificWeek(
      String canteenId, int year, String week, bool liked) async {
    try {
      final dishMenuModels = await mensaApiClient.getMensaMenusForSpecificWeek(canteenId, year, week, liked);
      return dishMenuModels;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<String>?> getFavoriteDishIds() async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteDishIds = prefs.getStringList(_favoriteDishIdsKey);
    return favoriteDishIds;
  }

  @override
  Future<void> updateFavoriteDishIds(List<String> favoriteDishIds) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(_favoriteDishIdsKey, favoriteDishIds);
  }


  @override
  Future<SortOption?> getSortOption() async {
    final prefs = await SharedPreferences.getInstance();

    final cachedSortOption = prefs.getString(_dishSortOptionKey);

    if (cachedSortOption == null) {
      return null;
    }

    for (var element in SortOption.values) {
      if (element.name == cachedSortOption) {
        return element;
      }
    }
    return null;
  }

  @override
  Future<void> setSortOption(SortOption sortOption) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_dishSortOptionKey, sortOption.name);
  }
}
