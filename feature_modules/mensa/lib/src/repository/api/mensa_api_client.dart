import 'dart:convert';

import 'package:core/api.dart';
import 'package:get_it/get_it.dart';

import 'api.dart';
import 'models/menu/menu_day_model.dart';
import 'models/taste_profile/taste_profile_model.dart';

class MensaApiClient {
  final _baseApiClient = GetIt.I.get<BaseApiClient>();

  Future<List<MensaModel>> getMensaModels() async {
    try {
      final response = await _baseApiClient.get(MensaApiEndpoints.getMensaModels());

      if (response.statusCode == 200) {
        final jsonList = json.decode(response.body) as List<dynamic>;
        return jsonList.map((json) => MensaModel.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to load mensa data');
      }
    } catch (e) {
      throw Exception('Failed to parse mensa data: $e');
    }
  }

  Future<List<MenuDayModel>> getMenuDayForMensa(String canteenId) async {
    try {
      final response = await _baseApiClient.get(MensaApiEndpoints.getMenuDayForMensa(canteenId));

      if (response.statusCode == 200) {
        final jsonList = json.decode(response.body) as List<dynamic>;
        return jsonList.map((json) => MenuDayModel.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to load menu data for mensa');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to parse menu data for mensa: $e');
    }
  }

  Future<TasteProfileModel> getTasteProfile() async {
    try {
      final response = await _baseApiClient.get(MensaApiEndpoints.getTasteProfile());

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body) as Map<String, dynamic>;
        return TasteProfileModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load taste profile data');
      }
    } catch (e) {
      throw Exception('Failed to load taste profile data: $e');
    }
  }

  Future<bool> toggleFavoriteMensaId(String mensaId) async {
    try {
      final response = await _baseApiClient.post(MensaApiEndpoints.toggleFavoriteMensaId(mensaId));

      if (response.statusCode == 200) {
        return response.body == 'true';
      } else {
        throw Exception('Failed to toggle favorite mensa');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> toggleFavoriteDishId(String dishId) async {
    try {
      final response = await _baseApiClient.post(MensaApiEndpoints.toggleFavoriteDishId(dishId));

      if (response.statusCode == 200) {
        return response.body == 'true';
      } else {
        throw Exception('Failed to toggle favorite dish');
      }
    } catch (e) {
      rethrow;
    }
  }
}
