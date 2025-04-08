import 'package:core/api.dart';
import 'package:get_it/get_it.dart';

import 'roomfinder_api_endpoints.dart';

class RoomfinderApiClient {
  final _baseApiClient = GetIt.I.get<BaseApiClient>();

  Future<String> getRoomfinderData() async {
    final response = await _baseApiClient.get(ExploreApiEndpoints.getRoomfinderAll());

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load cinema data - ${response.statusCode}');
    }
  }
}
