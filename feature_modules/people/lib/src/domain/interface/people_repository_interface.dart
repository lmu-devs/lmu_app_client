import '../model/people.dart';

abstract class PeopleRepositoryInterface {
  Future<People?> getPeople();

  Future<People?> getCachedPeople();

  Future<void> favorPeople();
}
