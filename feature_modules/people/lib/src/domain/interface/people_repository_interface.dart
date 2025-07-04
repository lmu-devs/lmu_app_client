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
}
