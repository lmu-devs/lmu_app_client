import 'dart:convert';

import 'package:core/api.dart';
import 'package:get_it/get_it.dart';

import 'models/sports_model.dart';
import 'sports_api_endpoints.dart';

class SportsApiClient {
  final _baseApiClient = GetIt.I.get<BaseApiClient>();

  Future<SportsModel> getSports() async {
    final response = await _baseApiClient.get(SportsApiEndpoints.sports);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return SportsModel.fromJson(json);
    } else {
      throw Exception('Failed to load sports');
    }
  }
}
