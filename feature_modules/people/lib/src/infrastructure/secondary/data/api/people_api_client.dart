import 'dart:convert';

import 'package:core/api.dart';

import '../dto/peoples_dto.dart';
import 'people_api_endpoints.dart';

class PeopleApiClient {
  const PeopleApiClient(this._baseApiClient);
  final BaseApiClient _baseApiClient;

  Future<PeoplesDto> getPeople() async {
    final response = await _baseApiClient.get(PeopleApiEndpoints.people);
    final responseJson = json.decode(response.body) as Map<String, dynamic>;
    return PeoplesDto.fromJson(responseJson);
  }
}
