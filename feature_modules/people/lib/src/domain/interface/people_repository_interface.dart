import '../model/people_category.dart';

abstract class PeopleRepositoryInterface {
  Future<List<PeopleCategory>?> getPeople();

  Future<List<PeopleCategory>?> getCachedPeople();

  Future<void> deleteCachedPeople();
}
