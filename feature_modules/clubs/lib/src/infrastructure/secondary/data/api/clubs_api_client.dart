import 'dart:convert';

import 'package:core/api.dart';

import '../dto/clubs_dto.dart';
import 'clubs_api_endpoints.dart';

class ClubsApiClient {
  const ClubsApiClient(this._baseApiClient);
  final BaseApiClient _baseApiClient;

  Future<ClubsDto> getClubs() async {
    final response = await _baseApiClient.get(ClubsApiEndpoints.clubs, version: 1);
    final responseJson = json.decode(response.body) as Map<String, dynamic>;
    return ClubsDto.fromJson(responseJson);
  }
}
