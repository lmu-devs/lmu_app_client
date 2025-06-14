import '../../domain/interface/people_repository_interface.dart';
import '../../domain/model/people_category.dart';

class GetCachedPeopleUsecase {
  const GetCachedPeopleUsecase(this.repository);

  final PeopleRepositoryInterface repository;

  Future<List<PeopleCategory>?> call() => repository.getCachedPeople();
}
