import '../../../domain/interface/benefits_repository_interface.dart';
import '../../../domain/models/benefit_category.dart';
import '../data/api/benefits_api_client.dart';
import '../data/storage/benefits_storage.dart';

class BenefitsRepository implements BenefitsRepositoryInterface {
  const BenefitsRepository(this._apiClient, this._storage);
  final BenefitsApiClient _apiClient;
  final BenefitsStorage _storage;

  @override
  Future<List<BenefitCategory>?> getBenefits() async {
    try {
      final response = await _apiClient.getBenefits();
      _storage.saveBenefits(response);
      return response.map((e) => e.toDomain()).toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<BenefitCategory>?> getCachedBenefits() async {
    final cachedBenefits = await _storage.getBenefits();
    if (cachedBenefits == null) return null;
    try {
      return cachedBenefits.map((e) => e.toDomain()).toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> deleteCachedBenefits() async {
    await _storage.deleteBenefits();
  }
}
