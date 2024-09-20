import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/mensa_menu_week_model.dart';
import 'models/mensa_model.dart';

class MensaApiClient {
  Future<List<MensaModel>> getMensaModels() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.lmu-dev.org/eat/v1/canteens/'),
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

  Future<MensaMenuWeekModel> getMensaMenuForSpecificWeek(String canteenId, int year, String week) async {
    try {
      final response = await http.get(
        Uri.parse('https://api.lmu-dev.org/eat/v1/menus/$canteenId/$year/$week'),
      );

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body) as Map<String, dynamic>;
        return MensaMenuWeekModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load menu data for mensa');
      }
    } catch (e) {
      throw Exception('Failed to parse menu data for mensa: $e');
    }
  }
}
