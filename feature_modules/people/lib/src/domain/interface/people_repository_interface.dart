import '../model/people.dart';

abstract class PeopleRepositoryInterface {
  /// Fetches the latest People data from the remote source.
  ///
  /// Throws a [DomainException] on failure.
  Future<List<People>> getPeople();

  /// Retrieves cached People data, if available.
  ///
  /// Returns `null` if no cached data exists.
  Future<List<People>?> getCachedPeople();

  /// Deletes any cached People data.
  Future<void> deletePeople();

  /// Toggles the favorite status of a person
  Future<void> toggleFavorite(int personId);

  /// Checks if a person is marked as favorite
  Future<bool> isFavorite(int personId);

  /// Gets all favorite person IDs
  Future<List<int>> getFavoriteIds();
}
