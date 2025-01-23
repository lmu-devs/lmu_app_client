import 'dart:convert';

import 'package:core/api.dart';
import 'package:get_it/get_it.dart';

import 'sports_api_endpoints.dart';
import 'models/sports_model.dart';

class SportsApiClient {
  final _baseApiClient = GetIt.I.get<BaseApiClient>(); 

  Future<SportsModel> getSports() async {
    final response = await _baseApiClient.get(SportsApiEndpoints.sports);
    return SportsModel.fromJson(jsonDecode(response.body));
  }
}