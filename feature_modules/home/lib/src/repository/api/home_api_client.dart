import 'dart:convert';

import 'package:core/api.dart';
import 'package:get_it/get_it.dart';

import 'home_api_endpoints.dart';
import 'models/home/home_data.dart';
import 'models/links/link_model.dart';

class HomeApiClient {
  final _baseApiClient = GetIt.I.get<BaseApiClient>();

  Future<HomeData> getHomeData() async {
    final response = await _baseApiClient.get(HomeApiEndpoints.getHomeData());

    final json = jsonDecode(response.body);
    return HomeData.fromJson(json);
  }

  Future<List<LinkModel>> getLinks() async {
    final response = await _baseApiClient.get(HomeApiEndpoints.getLinks());

    final jsonList = json.decode(response.body) as List<dynamic>;
    return jsonList.map((json) => LinkModel.fromJson(json as Map<String, dynamic>)).toList();
  }
}

const homeTestData = {
  "featured": [
    {
      "id": "tile-12345445",
      "title": "New Cinema Program",
      "priority": 1,
      "description": "Check out the latest updates in our app.",
      "imageUrl": "https://example.com/images/feature-banner.png",
      "url": "/home/cinema",
      "urlType": "INTERNAL",
    },
    {
      "id": "tile-1234533423423",
      "title": "Discover Our New Features",
      "priority": 3,
      "description": "Check out the latest updates in our app. You can see more",
      "imageUrl": "https://example.com/images/feature-banner.png",
      "url": "/home/benefits",
      "urlType": "EXTERNAL",
      "startDate": "2025-04-22T08:00:00.000Z",
      "endDate": "2025-04-24T12:18:30.000Z"
    }
  ],
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
