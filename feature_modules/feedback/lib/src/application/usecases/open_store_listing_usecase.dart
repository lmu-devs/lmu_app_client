import '../../domain/interfaces/app_review_repository_interface.dart';

class OpenStoreListingUsecase {
  const OpenStoreListingUsecase(this._repository);

  final AppReviewRepositoryInterface _repository;

  Future<void> call() => _repository.openStoreListing();
}
