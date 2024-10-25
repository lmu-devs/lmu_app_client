import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'api/mensa_api_client.dart';
import 'api/models/mensa_menu_week_model.dart';
import 'api/models/mensa_model.dart';

abstract class MensaRepository {
  Future<List<MensaModel>> getMensaModels();

  Future<List<String>?> getFavoriteMensaIds();

  Future<void> updateFavoriteMensaIds(List<String> favoriteMensaIds);

  Future<List<MensaMenuWeekModel>> getMensaMenusForSpecificWeek(String canteenId, int year, String week, bool liked);
}

class ConnectedMensaRepository implements MensaRepository {
  ConnectedMensaRepository({
    required this.mensaApiClient,
  });

  final MensaApiClient mensaApiClient;

  static const String _mensaModelsCacheKey = 'mena_models_cache_key';
  static const String _mensaModelCacheDateKey = 'mensa_models_cache_date_key';
  static const Duration _mensaModelsCacheDuration = Duration(days: 30);

  static const String _favoriteMensaIdsKey = 'favorite_mensa_ids_key';

  @override
  Future<List<MensaModel>> getMensaModels({bool forceRefresh = false}) async {
    final prefs = await SharedPreferences.getInstance();

    final cachedData = prefs.getString(_mensaModelsCacheKey);
    final cachedTime = prefs.getString(_mensaModelCacheDateKey);
    final cachedDateTime = cachedTime != null ? DateTime.parse(cachedTime) : null;
    final cachedTimeExceeded =
        cachedDateTime != null && DateTime.now().difference(cachedDateTime) > _mensaModelsCacheDuration;

    if (cachedData != null && !cachedTimeExceeded && !forceRefresh) {
      final jsonList = json.decode(cachedData) as List<dynamic>;
      return jsonList.map((json) => MensaModel.fromJson(json as Map<String, dynamic>)).toList();
    }

    try {
      final mensaModels = await mensaApiClient.getMensaModels();
      final jsonResponse = json.encode(mensaModels.map((mensa) => mensa.toJson()).toList());
      await prefs.setString(_mensaModelsCacheKey, jsonResponse);
      await prefs.setString(_mensaModelCacheDateKey, DateTime.now().toIso8601String());

      return mensaModels;
    } catch (e) {
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
  Future<void> updateFavoriteMensaIds(List<String> favoriteMensaIds) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(_favoriteMensaIdsKey, favoriteMensaIds);
  }

  /// Cache storing missing for now
  @override
  Future<List<MensaMenuWeekModel>> getMensaMenusForSpecificWeek(String canteenId, int year, String week, bool liked) async {
    try {
      final mensaMenuModels = await mensaApiClient.getMensaMenusForSpecificWeek(canteenId, year, week, liked);
      return mensaMenuModels;
    } catch (e) {
      rethrow;
    }
  }
}
