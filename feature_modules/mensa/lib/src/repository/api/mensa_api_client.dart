import 'dart:convert';

import 'package:core/api.dart';
import 'package:get_it/get_it.dart';

import 'api.dart';
import 'models/menu/menu_day_model.dart';
import 'models/taste_profile/taste_profile_model.dart';

class MensaApiClient {
  final _baseApiClient = GetIt.I.get<BaseApiClient>();

  Future<List<MensaModel>> getMensaModels() async {
    final response = await _baseApiClient.get(MensaApiEndpoints.getMensaModels());

    if (response.statusCode == 504) {
      throw Exception('Failed to load mensa data - ${response.statusCode}');
    }

    final jsonList = json.decode(response.body) as List<dynamic>;
    return jsonList.map((json) => MensaModel.fromJson(json as Map<String, dynamic>)).toList();
  }

  Future<List<MenuDayModel>> getMenuDayForMensa(String canteenId) async {
    final response = await _baseApiClient.get(MensaApiEndpoints.getMenuDayForMensa(canteenId));

    final jsonList = json.decode(response.body) as List<dynamic>;
    return jsonList.map((json) => MenuDayModel.fromJson(json as Map<String, dynamic>)).toList();
  }

  Future<TasteProfileModel> getTasteProfile() async {
    final response = await _baseApiClient.get(MensaApiEndpoints.getTasteProfile());

    final jsonMap = json.decode(response.body) as Map<String, dynamic>;
    return TasteProfileModel.fromJson(jsonMap);
  }

  Future<bool> toggleFavoriteMensaId(String mensaId) async {
    final response = await _baseApiClient.post(MensaApiEndpoints.toggleFavoriteMensaId(mensaId));

    if (response.statusCode != 200) {
      throw Exception('Failed to toggle favorite mensa - ${response.statusCode}');
    }

    return response.body == 'true';
  }

  Future<bool> toggleFavoriteDishId(String dishId) async {
    final response = await _baseApiClient.post(MensaApiEndpoints.toggleFavoriteDishId(dishId));

    if (response.statusCode != 200) {
      throw Exception('Failed to toggle favorite dish - ${response.statusCode}');
    }

    return response.body == 'true';
  }
}
