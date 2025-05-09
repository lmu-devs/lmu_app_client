import '../../domain/interface/benefits_repository_interface.dart';

class DeleteCachedBenefitsUsecase {
  const DeleteCachedBenefitsUsecase(this.repository);

  final BenefitsRepositoryInterface repository;

  Future<void> call() => repository.deleteCachedBenefits();
}
