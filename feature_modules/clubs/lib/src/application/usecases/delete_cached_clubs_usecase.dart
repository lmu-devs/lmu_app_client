import '../../domain/interface/clubs_repository_interface.dart';

class DeleteCachedClubsUsecase {
  const DeleteCachedClubsUsecase(this._repository);
  final ClubsRepositoryInterface _repository;

  Future<void> call() => _repository.deleteCachedClubs();
}
