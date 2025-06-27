import '../../../domain/interface/people_repository_interface.dart';
import '../../../domain/model/people.dart';
import '../../../domain/exception/people_generic_exception.dart';
import '../data/api/people_api_client.dart';
import '../data/storage/people_storage.dart';

class PeopleRepository implements PeopleRepositoryInterface {
  const PeopleRepository(this._apiClient, this._storage);

  final PeopleApiClient _apiClient;
  final PeopleStorage _storage;

  @override
  Future<People> getPeople() async {
    try {
      final retrievedPeopleData = await _apiClient.getPeople();
      await _storage.savePeople(retrievedPeopleData);
      return retrievedPeopleData.toDomain();
    } catch (e) {
      throw const PeopleGenericException();
    }
  }

  @override
  Future<People?> getCachedPeople() async {
    final cachedPeopleData = await _storage.getPeople();
    if (cachedPeopleData == null) return null;
    try {
      return cachedPeopleData.toDomain();
    } catch (e) {
      deletePeople();
      return null;
    }
  }

  @override
  Future<void> deletePeople() async {
    await _storage.deletePeople();
  }
}
