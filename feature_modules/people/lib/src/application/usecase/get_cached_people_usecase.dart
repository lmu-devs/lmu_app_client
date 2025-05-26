import '../../domain/interface/people_repository_interface.dart';
import '../../domain/model/people.dart';

class GetCachedPeopleUsecase {
  const GetCachedPeopleUsecase(this.repository);

  final PeopleRepositoryInterface repository;

  Future<People?> call() => repository.getCachedPeople();
}
