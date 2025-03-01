import 'dart:convert';

import 'package:core/api.dart';
import 'package:get_it/get_it.dart';

import 'home_api_endpoints.dart';
import 'models/benefits/benefit_model.dart';
import 'models/home/home_data.dart';
import 'models/links/link_model.dart';

class HomeApiClient {
  final _baseApiClient = GetIt.I.get<BaseApiClient>();

  Future<HomeData> getHomeData() async {
    // return HomeData.fromJson(homeTestData);
    try {
      final response = await _baseApiClient.get(HomeApiEndpoints.getHomeData());

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return HomeData.fromJson(json);
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

  Future<List<BenefitModel>> getBenefits() async {
    final response = await _baseApiClient.get(HomeApiEndpoints.getBenefits());

    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body) as List<dynamic>;
      return jsonList.map((json) => BenefitModel.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load benefit data - ${response.statusCode}');
    }
  }
}

const homeTestData = {
  "featured": [],
  "tiles": [
    {"type": "TIMELINE", "size": 2, "title": "Timeline", "description": null, "data": null},
    {"type": "NEWS", "size": 1, "title": "News", "description": null, "data": []},
    {"type": "EVENTS", "size": 1, "title": "Events", "description": null, "data": []},
    {"type": "ROOMFINDER", "size": 2, "title": "Roomfinder", "description": null, "data": null},
    {"type": "CINEMAS", "size": 1, "title": "Cinema", "description": null, "data": []},
    {"type": "SPORTS", "size": 1, "title": "Sports", "description": "124 courses", "data": null},
    {"type": "BENEFITS", "size": 1, "title": "Benefits", "description": "124 beneftis", "data": null},
    {"type": "LINKS", "size": 1, "title": "Links", "description": "124 links", "data": null},
    {"type": "WISHLIST", "size": 1, "title": "Wishlist", "description": "7 features", "data": null},
    {"type": "FEEDBACK", "size": 1, "title": "Feedback", "description": "für die App", "data": null}
  ]
};
