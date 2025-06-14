import '../../domain/interface/people_repository_interface.dart';

class DeleteCachedPeopleUsecase {
  const DeleteCachedPeopleUsecase(this.repository);

  final PeopleRepositoryInterface repository;

  Future<void> call() => repository.deleteCachedPeople();
}
