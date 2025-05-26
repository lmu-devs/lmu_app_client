import '../../../domain/interface/people_repository_interface.dart';
import '../../../domain/model/people.dart';
import '../data/api/people_api_client.dart';
import '../data/storage/people_storage.dart';

// Daten aus verschiedenen Quellen (API, Cache) holen und in Domain-Modelle umwandeln
class PeopleRepository implements PeopleRepositoryInterface {
  const PeopleRepository(this._apiClient, this._storage);

  final PeopleApiClient _apiClient; // API-Client, der die Daten von der API abruft
  final PeopleStorage _storage; // Lokaler Speicher, der die Daten zwischenspeichert

  @override
  Future<People?> getPeople() async {
    try {
      final retrivedPeopleData = await _apiClient.getPeople();
      await _storage.savePeople(retrivedPeopleData);
      return retrivedPeopleData.toDomain();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<People?> getCachedPeople() async {
    final cachedPeopleData = await _storage.getPeople();
    if (cachedPeopleData == null) return null;
    try {
      return cachedPeopleData.toDomain();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> deletePeople() async {
    await _storage.deletePeople();
  }
}
