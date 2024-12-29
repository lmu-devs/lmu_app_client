import 'dart:convert';

import 'package:shared_api/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/mensa_api_client.dart';
import 'api/models/mensa/mensa_model.dart';
import 'api/models/menu/menu_day_model.dart';
import 'api/models/menu/price_category.dart';
import 'api/models/taste_profile/taste_profile.dart';
import 'api/models/user_preferences/sort_option.dart';

abstract class MensaRepository {
  Future<List<MensaModel>> getMensaModels();

  Future<bool> toggleFavoriteMensaId(String mensaId);

  Future<List<String>?> getFavoriteMensaIds();

  Future<void> saveFavoriteMensaIds(List<String> favoriteMensaIds);

  Future<List<String>?> getFavoriteDishIds();

  Future<void> updateFavoriteDishIds(List<String> favoriteDishIds);

  Future<List<MenuDayModel>> getMenuDayForMensa(String canteenId);

  Future<TasteProfileModel> getTasteProfileContent();

  Future<TasteProfileStateModel> getTasteProfileState();

  Future<void> saveTasteProfileState(TasteProfileStateModel saveModel);

  Future<SortOption?> getSortOption();

  Future<void> setSortOption(SortOption mensaUserPreferences);

  Future<PriceCategory?> getPriceCategory();

  Future<void> setPriceCategory(PriceCategory priceCategory);

  Future<void> deleteAllLocalData();
}

/// MensaRepository implementation for fetching mensa data from the API
class ConnectedMensaRepository implements MensaRepository {
  ConnectedMensaRepository({
    required this.mensaApiClient,
    required this.userService,
  });

  final MensaApiClient mensaApiClient;
  final UserService userService;

  static const String _mensaModelsCacheKey = 'mensa_models_cache_key';

  static const String _favoriteMensaIdsKey = 'favorite_mensa_ids_key';
  static const String _favoriteDishIdsKey = 'favorite_dish_ids_key';

  static const String _tasteProfileKey = 'taste_profile_key';
  static const String _pasteProfileSelectionsKey = 'taste_profile_selections_key';

  static const String _mensaSortOptionKey = 'mensa_sort_option';
  static const String _menuPriceCategory = 'menu_price_category';
  static const String _menuBaseKey = 'mensa_menu_base_key';

  /// Function to fetch mensa models from the API, [forceRefresh] parameter can be used to ignore the cache
  @override
  Future<List<MensaModel>> getMensaModels({bool forceRefresh = false}) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final userApiKey = userService.userApiKey;

      final mensaModels = await mensaApiClient.getMensaModels(userApiKey: userApiKey);
      final jsonResponse = json.encode(mensaModels.map((mensa) => mensa.toJson()).toList());

      await prefs.setString(_mensaModelsCacheKey, jsonResponse);

      return mensaModels;
    } catch (e) {
      final cachedData = prefs.getString(_mensaModelsCacheKey);
      if (cachedData != null) {
        final jsonList = json.decode(cachedData) as List<dynamic>;
        return jsonList.map((json) => MensaModel.fromJson(json as Map<String, dynamic>)).toList();
      }
      rethrow;
    }
  }

  @override
  Future<List<String>?> getFavoriteMensaIds() async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteMensaIds = prefs.getStringList(_favoriteMensaIdsKey);
    return favoriteMensaIds;
  }

  @override
  Future<void> saveFavoriteMensaIds(List<String> favoriteMensaIds) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(_favoriteMensaIdsKey, favoriteMensaIds);
  }

  @override
  Future<List<String>?> getFavoriteDishIds() async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteDishIds = prefs.getStringList(_favoriteDishIdsKey);
    return favoriteDishIds;
  }

  @override
  Future<bool> toggleFavoriteMensaId(String mensaId) async {
    final userApiKey = userService.userApiKey;

    if (userApiKey == null) throw Exception('User api key is null');

    return await mensaApiClient.toggleFavoriteMensaId(mensaId, userApiKey: userApiKey);
  }

  @override
  Future<void> updateFavoriteDishIds(List<String> favoriteDishIds) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(_favoriteDishIdsKey, favoriteDishIds);
  }

  @override
  Future<List<MenuDayModel>> getMenuDayForMensa(String canteenId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_menuBaseKey$canteenId';
    final userApiKey = userService.userApiKey;

    try {
      final mensaMenuModels = await mensaApiClient.getMenuDayForMensa(canteenId, userApiKey: userApiKey);
      await prefs.setString(key, json.encode(mensaMenuModels.map((e) => e.toJson()).toList()));
      return mensaMenuModels;
    } catch (e) {
      final cachedMenu = prefs.getString(key);
      if (cachedMenu != null) {
        final jsonList = json.decode(cachedMenu) as List<dynamic>;
        final menuModels = jsonList.map((json) => MenuDayModel.fromJson(json as Map<String, dynamic>)).toList();
        final today = DateTime.now();
        final todayString = '${today.year}-${today.month}-${today.day}';
        final todayIndex = menuModels.indexWhere((element) => element.date == todayString);
        if (todayIndex == -1) {
          await prefs.remove(key);
          rethrow;
        }
        final filteredMenuModels = menuModels.sublist(todayIndex);
        return filteredMenuModels;
      }
      rethrow;
    }
  }

  @override
  Future<TasteProfileModel> getTasteProfileContent() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final tasteProfile = await mensaApiClient.getTasteProfile();
      await prefs.setString(_tasteProfileKey, json.encode(tasteProfile.toJson()));
      return tasteProfile;
    } catch (e) {
      final cachedTasteProfile = prefs.getString(_tasteProfileKey);
      if (cachedTasteProfile != null) {
        final jsonMap = json.decode(cachedTasteProfile) as Map<String, dynamic>;
        return TasteProfileModel.fromJson(jsonMap);
      }
      rethrow;
    }
  }

  @override
  Future<TasteProfileStateModel> getTasteProfileState() async {
    final prefs = await SharedPreferences.getInstance();
    final saveModel = prefs.getString(_pasteProfileSelectionsKey);

    if (saveModel == null) {
      return TasteProfileStateModel.empty();
    }

    return TasteProfileStateModel.fromJson(json.decode(saveModel));
  }

  @override
  Future<void> saveTasteProfileState(TasteProfileStateModel saveModel) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_pasteProfileSelectionsKey, json.encode(saveModel.toJson()));
  }

  @override
  Future<SortOption?> getSortOption() async {
    final prefs = await SharedPreferences.getInstance();

    final cachedSortOption = prefs.getString(_mensaSortOptionKey);

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

    await prefs.setString(_mensaSortOptionKey, sortOption.name);
  }

  @override
  Future<PriceCategory?> getPriceCategory() async {
    final prefs = await SharedPreferences.getInstance();

    final cachedPriceCategory = prefs.getString(_menuPriceCategory);

    if (cachedPriceCategory == null) {
      return null;
    }

    for (var element in PriceCategory.values) {
      if (element.name == cachedPriceCategory) {
        return element;
      }
    }
    return null;
  }

  @override
  Future<void> setPriceCategory(PriceCategory priceCategory) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_menuPriceCategory, priceCategory.name);
  }

  @override
  Future<void> deleteAllLocalData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_mensaModelsCacheKey);
    await prefs.remove(_favoriteMensaIdsKey);
    await prefs.remove(_favoriteDishIdsKey);
    await prefs.remove(_tasteProfileKey);
    await prefs.remove(_pasteProfileSelectionsKey);
    await prefs.remove(_mensaSortOptionKey);
    await prefs.remove(_menuPriceCategory);
    await prefs.remove(_menuBaseKey);
  }
}
