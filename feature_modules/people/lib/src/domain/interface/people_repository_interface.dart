import '../model/people.dart';

abstract class PeopleRepositoryInterface {
  /// Fetches the latest People data from the remote source.
  ///
  /// Throws a [DomainException] on failure.
  Future<People> getPeople();

  /// Retrieves cached People data, if available.
  ///
  /// Returns `null` if no cached data exists.
  Future<People?> getCachedPeople();

  /// Deletes any cached People data.
  Future<void> deletePeople();
}
