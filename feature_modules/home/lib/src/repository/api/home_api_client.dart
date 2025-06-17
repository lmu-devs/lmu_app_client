import 'dart:convert';

import 'package:core/api.dart';
import 'package:get_it/get_it.dart';

import 'home_api_endpoints.dart';
import 'models/home/home_data.dart';
import 'models/links/link_model.dart';

class HomeApiClient {
  final _baseApiClient = GetIt.I.get<BaseApiClient>();

  Future<HomeData> getHomeData() async {
    //final response = await _baseApiClient.get(HomeApiEndpoints.getHomeData());

    //final json = jsonDecode(response.body);
    return HomeData.fromJson(homeTestData);
  }

  Future<List<LinkModel>> getLinks() async {
    final response = await _baseApiClient.get(HomeApiEndpoints.getLinks(), version: 2);

    final jsonList = json.decode(response.body) as List<dynamic>;
    return jsonList.map((json) => LinkModel.fromJson(json as Map<String, dynamic>)).toList();
  }
}

const homeTestData = {
  "featured": [],
  "tiles": [
    {"type": "LIBRARY", "size": 1, "title": "Library", "description": null, "data": null},
    {"type": "ROOMFINDER", "size": 1, "title": "Roomfinder", "description": null, "data": null},
    {"type": "SPORTS", "size": 1, "title": "Sports", "description": null, "data": null},
    {"type": "CINEMAS", "size": 1, "title": "Cinema", "description": null, "data": null},
    {"type": "LINKS", "size": 1, "title": "Links", "description": null, "data": null},
    {"type": "BENEFITS", "size": 1, "title": "Benefits", "description": null, "data": null},
    {"type": "TIMELINE", "size": 1, "title": "Timeline", "description": null, "data": null},
    {"type": "FEEDBACK", "size": 1, "title": "Feedback", "description": null, "data": null}
  ]
};
