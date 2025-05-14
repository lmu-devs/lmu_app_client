import '../../domain/interfaces/app_review_repository_interface.dart';

class OpenStoreListingUseCase {
  const OpenStoreListingUseCase(this._repository);

  final AppReviewRepositoryInterface _repository;

  Future<void> call() => _repository.openStoreListing();
}
