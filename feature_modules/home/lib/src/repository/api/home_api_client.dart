import 'dart:convert';

import 'package:core/api.dart';
import 'package:get_it/get_it.dart';

import 'home_api_endpoints.dart';
import 'models/home_model.dart';
import 'models/links/link_model.dart';

class HomeApiClient {
  final _baseApiClient = GetIt.I.get<BaseApiClient>();

  Future<HomeModel> getHomeData() async {
    try {
      final response = await _baseApiClient.get(HomeApiEndpoints.getHomeData());

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return HomeModel.fromJson(json);
      } else {
        throw Exception('Failed to load home data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<LinkModel>> getLinks() async {
    final response = await _baseApiClient.get(HomeApiEndpoints.getLinks());

    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body) as List<dynamic>;
      return jsonList.map((json) => LinkModel.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load link data - ${response.statusCode}');
    }
  }
}
