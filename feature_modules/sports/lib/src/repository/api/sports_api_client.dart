import 'dart:convert';

import 'package:core/api.dart';
import 'package:get_it/get_it.dart';

import 'models/sports_model.dart';
import 'sports_api_endpoints.dart';

class SportsApiClient {
  final _baseApiClient = GetIt.I.get<BaseApiClient>();

  Future<List<SportsModel>> getSports() async {
    final response = await _baseApiClient.get(SportsApiEndpoints.sports);

    final jsonList = json.decode(response.body) as List<dynamic>;
    return jsonList.map((json) => SportsModel.fromJson(json as Map<String, dynamic>)).toList();
  }
}
