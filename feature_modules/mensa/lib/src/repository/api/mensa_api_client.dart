import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/mensa/mensa_model.dart';
import 'models/menu/menu_day_model.dart';
import 'models/taste_profile/taste_profile_model.dart';

class MensaApiClient {
  Future<List<MensaModel>> getMensaModels() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.lmu-dev.org/eat/v1/canteens'),
      );

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
      final response = await http.get(
        Uri.parse('https://api.lmu-dev.org/eat/v1/menus?canteen_id=$canteenId'),
      );

      if (response.statusCode == 200) {
        final jsonList = json.decode(response.body) as List<dynamic>;
        return jsonList.map((json) => MenuDayModel.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to load menu data for mensa');
      }
    } catch (e) {
      throw Exception('Failed to parse menu data for mensa: $e');
    }
  }

  Future<TasteProfileModel> getTasteProfile() async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://api.lmu-dev.org/eat/v1/taste-profile",
        ),
      );

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
}
