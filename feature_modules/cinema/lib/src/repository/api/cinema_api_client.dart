import 'dart:convert';

import 'package:core/api.dart';
import 'package:get_it/get_it.dart';

import 'cinema_api_endpoints.dart';
import 'models/cinema_model.dart';

class CinemaApiClient {
  final _baseApiClient = GetIt.I.get<BaseApiClient>(); 

  Future<CinemaModel> getCinemas() async {
    final response = await _baseApiClient.get(CinemaApiEndpoints.getCinemas());
    return CinemaModel.fromJson(jsonDecode(response.body));
  }
}