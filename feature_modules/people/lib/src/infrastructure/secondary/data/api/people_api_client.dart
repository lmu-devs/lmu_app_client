import 'package:core/api.dart';

import '../dto/people_dto.dart';

class PeopleApiClient {
  const PeopleApiClient(this._baseApiClient);

  final BaseApiClient _baseApiClient;

  Future<List<PeopleDto>> getPeople() async {
    //final response = await _baseApiClient.get(PeopleApiEndpoints.people);
    //return PeopleDto.fromJson(jsonDecode(response.body));

    // Mockdata basierend auf dem Screenshot
    return [
      const PeopleDto(id: 1, name: 'Max Alstermann', title: 'Wis. Mitarbeiter'),
      const PeopleDto(id: 2, name: 'Erika Alsterfrau', title: 'Lehrbeauftragte'),
      const PeopleDto(id: 3, name: 'Maxime Ralsterfrau', title: 'Professor:in'),
      const PeopleDto(id: 4, name: 'Erika Alsterfrau', title: 'Professor:in'),
      const PeopleDto(id: 5, name: 'Prof. Dr. Frank Au', title: 'Professor:in'),
      const PeopleDto(id: 6, name: 'Prof. Dr. Max Alster', title: 'Professor:in'),
      const PeopleDto(id: 7, name: 'Prof. Dr. Marc Besterau', title: 'Professor'),
      const PeopleDto(id: 8, name: 'Prof. Med. Dr. Lisa Best', title: 'Professor:in'),
    ];
  }
}
