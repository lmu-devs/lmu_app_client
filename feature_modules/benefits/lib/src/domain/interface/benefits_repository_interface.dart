import '../models/benefit_category.dart';

abstract class BenefitsRepositoryInterface {
  Future<List<BenefitCategory>?> getBenefits();

  Future<List<BenefitCategory>?> getCachedBenefits();

  Future<void> deleteCachedBenefits();
}
