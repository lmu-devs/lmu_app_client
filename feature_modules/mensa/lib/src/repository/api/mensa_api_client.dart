import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/mensa_model.dart';

class MensaApiClient {
  Future<List<MensaModel>> getMensaModels() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:3000/api/mensadata'),
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
}
