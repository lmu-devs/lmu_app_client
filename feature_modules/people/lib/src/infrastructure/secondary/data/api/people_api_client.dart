import 'dart:convert';

import 'package:core/api.dart';

import '../dto/people_dto.dart';
import 'people_api_endpoints.dart';

class PeopleApiClient {
  const PeopleApiClient(this._baseApiClient);

  final BaseApiClient _baseApiClient; 

  Future<PeopleDto> getPeople() async {
    final response = await _baseApiClient.get(PeopleApiEndpoints.people);
    return PeopleDto.fromJson(jsonDecode(response.body));
  }
}
