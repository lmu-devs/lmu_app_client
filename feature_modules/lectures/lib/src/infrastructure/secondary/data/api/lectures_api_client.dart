import 'dart:convert';

import 'package:core/api.dart';

import '../dto/lectures_dto.dart';
import 'lectures_api_endpoints.dart';

class LecturesApiClient {
  const LecturesApiClient(this._baseApiClient);

  final BaseApiClient _baseApiClient;

  Future<LecturesDto> getLectures() async {
    return const LecturesDto(id: "1234234", name: "Natural Computing");
    final response = await _baseApiClient.get(LecturesApiEndpoints.lectures);
    return LecturesDto.fromJson(jsonDecode(response.body));
  }
}
