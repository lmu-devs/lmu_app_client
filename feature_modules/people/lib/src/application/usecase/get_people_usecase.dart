import '../../domain/interface/people_repository_interface.dart';
import '../../domain/model/people.dart';

class GetPeopleUsecase {
  const GetPeopleUsecase(this.repository);

// Repository stellt die Daten bereit oder übergibt Daten an Repository
  final PeopleRepositoryInterface repository;

  Future<People?> call() => repository.getPeople();
}
