import 'package:core/api.dart';

import '../dto/people_dto.dart';

class PeopleApiClient {
  const PeopleApiClient(this._baseApiClient);

  final BaseApiClient _baseApiClient;

  Future<PeopleDto> getPeople() async {
    //final response = await _baseApiClient.get(PeopleApiEndpoints.people);
    //return PeopleDto.fromJson(jsonDecode(response.body));
    return PeopleDto(id: '2', name: 'John Doe');
  }
}
