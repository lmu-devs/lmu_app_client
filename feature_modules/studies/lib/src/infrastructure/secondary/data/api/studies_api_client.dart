import 'dart:convert';

import 'package:core/api.dart';

import '../dto/faculty_dto.dart';
import 'studies_api_endpoints.dart';

class StudiesApiClient {
  const StudiesApiClient(this._baseApiClient);

  final BaseApiClient _baseApiClient;

  Future<List<FacultyDto>> getFaculties() async {
    final response = await _baseApiClient.get(StudiesApiEndpoints.faculties);

    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => FacultyDto.fromJson(json)).toList();
  }
}
