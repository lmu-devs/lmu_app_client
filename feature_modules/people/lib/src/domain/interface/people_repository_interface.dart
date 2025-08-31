import '../model/people.dart';

abstract class PeopleRepositoryInterface {
  /// Fetches the latest People data from the remote source.
  ///
  /// Throws a [DomainException] on failure.
  Future<List<People>> getPeople();
}
