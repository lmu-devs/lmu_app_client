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
      final categories = await _apiClient.getPeople();
      return PeopleMapper.mapToDomain(categories);
    } catch (e) {
      print('❌ Error in getPeople: $e');
      rethrow;
    }
  }

  @override
  Future<List<PeopleCategory>?> getCachedPeople() async {
    try {
      final categories = await _storage.getPeople();
      if (categories == null) return null;
      return PeopleMapper.mapToDomain(categories);
    } catch (e) {
      print('❌ Error in getCachedPeople: $e');
      return null;
    }
  }

  @override
  Future<void> deleteCachedPeople() async {
    try {
      await _storage.deletePeople();
    } catch (e) {
      print('❌ Error in deleteCachedPeople: $e');
      rethrow;
    }
  }
}
