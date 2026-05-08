import 'dart:convert';

import 'package:core/api.dart';

import '../dto/release_notes_dto.dart';
import 'endpoint/release_notes_api_endpoints.dart';

class ReleaseNotesApiClient {
  const ReleaseNotesApiClient(this._baseApiClient);

  final BaseApiClient _baseApiClient;

  Future<RelaseNotesDto> getReleaseNotes({required String version}) async {
    final response = await _baseApiClient.get(ReleaseNotesApiEndpoints.releaseNotesWithVersion(version));
    final reponseJson = json.decode(response.body) as Map<String, dynamic>;
    return RelaseNotesDto.fromJson(reponseJson);
  }
}
