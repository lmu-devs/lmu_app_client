import '../../domain/interface/people_repository_interface.dart';
import '../../domain/model/people_category.dart';

class GetPeopleUsecase {
  const GetPeopleUsecase(this.repository);

// Repository stellt die Daten bereit oder übergibt Daten an Repository
  final PeopleRepositoryInterface repository;

  Future<List<PeopleCategory>?> call() => repository.getPeople();
}
