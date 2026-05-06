import 'dart:convert';

import 'package:core/api.dart';

import '../dto/club_dto.dart';
import 'clubs_api_endpoints.dart';

class ClubsApiClient {
  const ClubsApiClient(this._baseApiClient);
  final BaseApiClient _baseApiClient;

  Future<List<ClubDto>> getClubs() async {
    final response = await _baseApiClient.get(ClubsApiEndpoints.clubs, version: 1);
    final responseJson = json.decode(response.body) as List<dynamic>;
    return responseJson.map((e) => ClubDto.fromJson(e as Map<String, dynamic>)).toList();
  }
}
