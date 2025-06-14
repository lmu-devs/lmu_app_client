import '../../../domain/interface/people_repository_interface.dart';
import '../../../domain/model/people_category.dart';
import '../data/api/people_api_client.dart';
import '../data/dto/people_mapper.dart';
import '../data/storage/people_storage.dart';

// Daten aus verschiedenen Quellen (API, Cache) holen und in Domain-Modelle umwandeln
class PeopleRepository implements PeopleRepositoryInterface {
  const PeopleRepository(this._apiClient, this._storage);

  final PeopleApiClient _apiClient; // API-Client, der die Daten von der API abruft
  final PeopleStorage _storage; // Lokaler Speicher, der die Daten zwischenspeichert

  @override
  Future<List<PeopleCategory>?> getPeople() async {
    try {
      final response = await _apiClient.getPeople();
      _storage.savePeople(response);
      return PeopleMapper.mapToDomain(response);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<PeopleCategory>?> getCachedPeople() async {
    final cachedPeopleData = await _storage.getPeople();
    print("Get Cached People: $cachedPeopleData");
    if (cachedPeopleData == null) return null;
    try {
      return PeopleMapper.mapToDomain(cachedPeopleData);
    } catch (e) {
      deleteCachedPeople();
      return null;
    }
  }

  @override
  Future<void> deleteCachedPeople() async {
    await _storage.deletePeople();
  }
}
