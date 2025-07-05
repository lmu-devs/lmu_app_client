import 'dart:convert';

import 'package:core/api.dart';

import '../dto/feature_flag_dto.dart';
import 'endpoint/feature_toggle_api_endpoints.dart';
import 'error/app_update_required_api_error.dart';

class FeatureToggleApiClient {
  const FeatureToggleApiClient(this._baseApiClient);

  final BaseApiClient _baseApiClient;

  Future<List<FeatureFlagDto>> getFeatureFlags({required String version}) async {
    final response = await _baseApiClient.get(FeatureToggleApiEndpoints.featureFlagsWithVersion(version)).timeout(
          const Duration(seconds: 10),
        );

    if (response.statusCode == 426) throw AppUpdateRequiredApiError();

    final List<dynamic> responseJson = jsonDecode(response.body) as List<dynamic>;
    return responseJson.map((json) => FeatureFlagDto.fromJson(json)).toList();
  }
}
