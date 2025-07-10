import '../../../domain/interface/people_repository_interface.dart';
import '../../../domain/model/people.dart';
import '../../../domain/exception/people_generic_exception.dart';
import '../data/api/people_api_client.dart';
import '../data/storage/people_storage.dart';
import '../data/storage/people_favorites_storage.dart';

class PeopleRepository implements PeopleRepositoryInterface {
  const PeopleRepository(this._apiClient, this._storage, this._favoritesStorage);

  final PeopleApiClient _apiClient;
  final PeopleStorage _storage;
  final PeopleFavoritesStorage _favoritesStorage;

  @override
  Future<List<People>> getPeople() async {
    try {
      final wrapper = await _apiClient.getPeople();
      final favoriteIds = await _favoritesStorage.getFavoriteIds();

      // Extract the people list from the wrapper and merge with favorite status
      return wrapper.people.map((dto) {
        final isFavorite = favoriteIds.contains(dto.id);
        return dto.copyWith(isFavorite: isFavorite).toDomain();
      }).toList();
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

  @override
  Future<void> toggleFavorite(int personId) async {
    final isFavorite = await _favoritesStorage.isFavorite(personId);
    if (isFavorite) {
      await _favoritesStorage.removeFavorite(personId);
    } else {
      await _favoritesStorage.addFavorite(personId);
    }
  }

  @override
  Future<bool> isFavorite(int personId) async {
    return await _favoritesStorage.isFavorite(personId);
  }

  @override
  Future<List<int>> getFavoriteIds() async {
    return await _favoritesStorage.getFavoriteIds();
  }
}
