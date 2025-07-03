import 'package:shared_api/launch_flow.dart';

import '../../../domain/error/app_update_required_error.dart';
import '../../../domain/error/feature_toggle_generic_error.dart';
import '../../../domain/interface/feature_toggle_repository_interface.dart';
import '../data/api/error/app_update_required_api_error.dart';
import '../data/api/feature_toggle_api_client.dart';
import '../data/storage/feature_toggle_storage.dart';

class FeatureToggleRepository implements FeatureToggleRepositoryInterface {
  const FeatureToggleRepository(this._apiClient, this._storage, this._appVersion);

  final FeatureToggleApiClient _apiClient;
  final FeatureToggleStorage _storage;
  final String _appVersion;

  @override
  Future<List<FeatureFlag>> getFeatureFlags() async {
    try {
      final response = await _apiClient.getFeatureFlags(version: _appVersion);
      await _storage.saveFeatureFlags(response);
      return response.map((dto) => dto.toDomain()).toList();
    } catch (error) {
      if (error is AppUpdateRequiredApiError) throw AppUpdateRequiredError();

      final cachedFlags = await _storage.getFeatureFlags();
      if (cachedFlags != null) {
        return cachedFlags.map((dto) => dto.toDomain()).toList();
      }

      throw FeatureToggleGenericError();
    }
  }
}
