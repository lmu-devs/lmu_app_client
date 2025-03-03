import 'dart:convert';

import 'package:core/logging.dart';
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

  Future<bool> toggleFavoriteDishId(String mensaId);

  Future<List<String>?> getFavoriteDishIds();

  Future<void> saveFavoriteDishIds(List<String> favoriteDishIds);

  Future<List<String>> getUnsyncedFavoriteDishIds();

  Future<void> saveUnsyncedFavoriteDishId(String dishId);

  Future<void> removeUnsyncedFavoriteDishId(String dishId);

  Future<List<MenuDayModel>> getMenuDayForMensa(String canteenId);

  Future<TasteProfileModel> getTasteProfileContent();

  Future<TasteProfileStateModel> getTasteProfileState();

  Future<void> saveTasteProfileState(TasteProfileStateModel saveModel);

  Future<SortOption?> getSortOption();

  Future<void> setSortOption(SortOption mensaUserPreferences);

  Future<PriceCategory?> getPriceCategory();

  Future<void> setPriceCategory(PriceCategory priceCategory);

  Future<void> deleteAllLocalData();

  Future<void> deleteAllLocalizedData();
}

/// MensaRepository implementation for fetching mensa data from the API
class ConnectedMensaRepository implements MensaRepository {
  ConnectedMensaRepository({
    required this.mensaApiClient,
  });

  final MensaApiClient mensaApiClient;
  final _appLogger = AppLogger();

  static const String _mensaModelsCacheKey = 'mensa_models_cache_key';

  static const String _favoriteMensaIdsKey = 'favorite_mensa_ids_key';
  static const String _favoriteDishIdsKey = 'favorite_dish_ids_key';
  static const String _unsyncedFavoriteDishIdsKey = 'unsynced_favorite_dish_ids_key';

  static const String _tasteProfileKey = 'taste_profile_key';
  static const String _tasteProfileTimestampKey = 'taste_profile_timestamp_key';
  static const String _tasteProfileSelectionsKey = 'taste_profile_selections_key';

  static const String _mensaSortOptionKey = 'mensa_sort_option';
  static const String _menuPriceCategory = 'menu_price_category';
  static const String _menuBaseKey = 'mensa_menu_base_key';

  @override
  Future<List<MensaModel>> getMensaModels() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final mensaModels = await mensaApiClient.getMensaModels();
      final jsonResponse = json.encode(mensaModels.map((mensa) => mensa.toJson()).toList());

      await prefs.setString(_mensaModelsCacheKey, jsonResponse);

      return mensaModels;
    } catch (e) {
      final cachedData = prefs.getString(_mensaModelsCacheKey);
      if (cachedData != null) {
        final jsonList = json.decode(cachedData) as List<dynamic>;
        final mensaModels = jsonList.map((json) => MensaModel.fromJson(json as Map<String, dynamic>)).toList();
        _appLogger.logMessage('[MensaRepository]: Using mensa models from cache');
        return mensaModels;
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
  Future<bool> toggleFavoriteMensaId(String mensaId) async {
    return await mensaApiClient.toggleFavoriteMensaId(mensaId);
  }

  @override
  Future<void> saveFavoriteMensaIds(List<String> favoriteMensaIds) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(_favoriteMensaIdsKey, favoriteMensaIds);
    _appLogger.logMessage('[MensaRepository]: Saved local favorite mensa ids: $favoriteMensaIds');
  }

  @override
  Future<List<String>?> getFavoriteDishIds() async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteDishIds = prefs.getStringList(_favoriteDishIdsKey);
    return favoriteDishIds;
  }

  @override
  Future<bool> toggleFavoriteDishId(String mensaId) async {
    return await mensaApiClient.toggleFavoriteDishId(mensaId);
  }

  @override
  Future<void> saveFavoriteDishIds(List<String> favoriteDishIds) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(_favoriteDishIdsKey, favoriteDishIds);
    _appLogger.logMessage('[MensaRepository]: Saved local favorite dish ids: $favoriteDishIds');
  }

  @override
  Future<List<String>> getUnsyncedFavoriteDishIds() async {
    final currentFavoriteDishIds = await _getCurrentUnsyncedFavoriteDishIds();

    return currentFavoriteDishIds;
  }

  @override
  Future<void> saveUnsyncedFavoriteDishId(String dishId) async {
    final currentFavoriteDishIds = await _getCurrentUnsyncedFavoriteDishIds();

    if (currentFavoriteDishIds.contains(dishId)) {
      currentFavoriteDishIds.remove(dishId);
    } else {
      currentFavoriteDishIds.add(dishId);
    }

    await _saveUnsyncedFavoriteDishIds(currentFavoriteDishIds);
  }

  @override
  Future<void> removeUnsyncedFavoriteDishId(String dishId) async {
    final currentFavoriteDishIds = await _getCurrentUnsyncedFavoriteDishIds();

    if (currentFavoriteDishIds.contains(dishId)) {
      currentFavoriteDishIds.remove(dishId);
    }

    await _saveUnsyncedFavoriteDishIds(currentFavoriteDishIds);
  }

  Future<List<String>> _getCurrentUnsyncedFavoriteDishIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_unsyncedFavoriteDishIdsKey) ?? [];
  }

  Future<void> _saveUnsyncedFavoriteDishIds(List<String> dishIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_unsyncedFavoriteDishIdsKey, dishIds);
    _appLogger.logMessage('[MensaRepository]: Saved unsynced favorite dish ids: $dishIds');
  }

  @override
  Future<List<MenuDayModel>> getMenuDayForMensa(String canteenId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_menuBaseKey$canteenId';

    try {
      final mensaMenuModels = await mensaApiClient.getMenuDayForMensa(canteenId);
      await prefs.setString(key, json.encode(mensaMenuModels.map((e) => e.toJson()).toList()));
      return mensaMenuModels;
    } catch (e) {
      final cachedMenu = prefs.getString(key);
      if (cachedMenu != null) {
        final jsonList = json.decode(cachedMenu) as List<dynamic>;
        final menuModels = jsonList.map((json) => MenuDayModel.fromJson(json as Map<String, dynamic>)).toList();
        final today = DateTime.now();
        final filteredDays = menuModels.where((mensaDay) {
          DateTime mensaDate = DateTime.parse(mensaDay.date.replaceAll('-', '-').padLeft(10, '0'));
          return mensaDate.isAfter(today) || mensaDate.isAtSameMomentAs(today);
        }).toList();

        if (filteredDays.isEmpty) {
          await prefs.remove(key);
          rethrow;
        }

        _appLogger.logMessage('[MensaRepository]: Using menu models from cache');
        return filteredDays;
      }
      rethrow;
    }
  }

  @override
  Future<TasteProfileModel> getTasteProfileContent() async {
    final prefs = await SharedPreferences.getInstance();
    final lastTimestamp = prefs.getString(_tasteProfileTimestampKey);

    if (lastTimestamp != null) {
      final lastUpdate = DateTime.parse(lastTimestamp);
      _appLogger.logMessage('[MensaRepository]: TasteProfile last update: $lastUpdate');
      if (lastUpdate.day == DateTime.now().day) {
        final cachedTasteProfile = prefs.getString(_tasteProfileKey);
        if (cachedTasteProfile != null) {
          final jsonMap = json.decode(cachedTasteProfile) as Map<String, dynamic>;
          return TasteProfileModel.fromJson(jsonMap);
        }
      }
    }

    try {
      final tasteProfile = await mensaApiClient.getTasteProfile();
      await prefs.setString(_tasteProfileKey, json.encode(tasteProfile.toJson()));
      await prefs.setString(_tasteProfileTimestampKey, DateTime.now().toIso8601String());
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
    final saveModel = prefs.getString(_tasteProfileSelectionsKey);

    if (saveModel == null) {
      return TasteProfileStateModel.empty();
    }

    return TasteProfileStateModel.fromJson(json.decode(saveModel));
  }

  @override
  Future<void> saveTasteProfileState(TasteProfileStateModel saveModel) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_tasteProfileSelectionsKey, json.encode(saveModel.toJson()));
    _appLogger.logMessage('[MensaRepository]: Saved taste profile state: $saveModel');
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
    _appLogger.logMessage('[MensaRepository]: Saved sort option: $sortOption');
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
    _appLogger.logMessage('[MensaRepository]: Saved price category: $priceCategory');
  }

  @override
  Future<void> deleteAllLocalData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_mensaModelsCacheKey);
    await prefs.remove(_favoriteMensaIdsKey);
    await prefs.remove(_favoriteDishIdsKey);
    await prefs.remove(_tasteProfileKey);
    await prefs.remove(_tasteProfileSelectionsKey);
    await prefs.remove(_tasteProfileTimestampKey);
    await prefs.remove(_mensaSortOptionKey);
    await prefs.remove(_menuPriceCategory);
    await prefs.remove(_menuBaseKey);
    await prefs.remove(_unsyncedFavoriteDishIdsKey);

    _appLogger.logMessage('[MensaRepository]: Deleted all local data');
  }

  @override
  Future<void> deleteAllLocalizedData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_mensaModelsCacheKey);
    await prefs.remove(_tasteProfileKey);

    _appLogger.logMessage('[MensaRepository]: Deleted all localized data');
  }
}
