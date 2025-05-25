import 'dart:convert';

import 'package:core/api.dart';

import '../dto/benefits_dto.dart';
import 'benefits_api_endpoints.dart';

class BenefitsApiClient {
  const BenefitsApiClient(this._baseApiClient);
  final BaseApiClient _baseApiClient;

  Future<BenefitsDto> getBenefits() async {
    final response = await _baseApiClient.get(BenefitsApiEndpoints.benefits, version: 2);
    final reponseJson = json.decode(response.body) as Map<String, dynamic>;
    return BenefitsDto.fromJson(reponseJson);
  }
}
