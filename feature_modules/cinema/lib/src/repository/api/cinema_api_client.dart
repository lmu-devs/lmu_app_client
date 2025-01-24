import 'dart:convert';

import 'package:core/api.dart';
import 'package:get_it/get_it.dart';

import 'cinema_api_endpoints.dart';
import 'models/cinema_model.dart';
import 'models/screening_model.dart';

class CinemaApiClient {
  final _baseApiClient = GetIt.I.get<BaseApiClient>(); 

  Future<List<CinemaModel>> getCinemas({int? id}) async {
    final response = await _baseApiClient.get(CinemaApiEndpoints.getCinemas(id: id));

    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body) as List<dynamic>;
      return jsonList.map((json) => CinemaModel.fromJson(json as Map<String, dynamic>)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Failed to load cinema data - ${response.statusCode}');
    }
  }

  Future<List<ScreeningModel>> getScreenings() async {
    final response = await _baseApiClient.get(CinemaApiEndpoints.getScreenings());

    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body) as List<dynamic>;
      return jsonList.map((json) => ScreeningModel.fromJson(json as Map<String, dynamic>)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Failed to load screenings data - ${response.statusCode}');
    }
  }
}