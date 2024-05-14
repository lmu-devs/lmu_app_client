import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'api/mensa_api_client.dart';
import 'api/models/mensa_model.dart';

abstract class MensaRepository {
  Future<List<MensaModel>> getMensaModels();
}

class ConnectedMensaRepository implements MensaRepository {
  ConnectedMensaRepository({
    required this.mensaApiClient,
  });

  final MensaApiClient mensaApiClient;

  static const String _mensaModelsCacheKey = 'mena_models_cache_key';
  static const String _mensaModelCacheDateKey = 'mensa_models_cache_date_key';
  static const Duration _mensaModelsCacheDuration = Duration(days: 30);

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
}
