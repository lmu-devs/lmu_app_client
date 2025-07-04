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
  Future<List<People>> getPeople() async {
    try {
      final retrievedPeopleData = await _apiClient.getPeople();
      // For now, we'll just return the data directly
      // TODO: Implement proper caching for lists
      return retrievedPeopleData.map((dto) => dto.toDomain()).toList();
    } catch (e) {
      throw const PeopleGenericException();
    }
  }

  @override
  Future<List<People>?> getCachedPeople() async {
    // For now, return null (no caching for lists yet)
    // TODO: Implement proper caching for lists
    return null;
  }

  @override
  Future<void> deletePeople() async {
    await _storage.deletePeople();
  }
}
