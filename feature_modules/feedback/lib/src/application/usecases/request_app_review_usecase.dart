import '../../domain/interfaces/app_review_repository_interface.dart';

class RequestAppReviewUseCase {
  const RequestAppReviewUseCase(this._repository);

  final AppReviewRepositoryInterface _repository;

  Future<void> call() => _repository.requestReview();
}
