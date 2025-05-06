import '../../domain/interface/benefits_repository_interface.dart';
import '../../domain/models/benefit_category.dart';

class GetCachedBenefitsUsecase {
  const GetCachedBenefitsUsecase(this.repository);

  final BenefitsRepositoryInterface repository;

  Future<List<BenefitCategory>?> call() => repository.getCachedBenefits();
}
