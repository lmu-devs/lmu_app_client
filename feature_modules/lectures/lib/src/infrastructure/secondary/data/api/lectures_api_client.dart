import 'dart:convert';

import 'package:core/api.dart';

import '../dto/lecture_dto.dart';
import 'lectures_api_endpoints.dart';

class LecturesApiClient {
  const LecturesApiClient(this._baseApiClient);

  final BaseApiClient _baseApiClient;

  Future<List<LectureDto>> getLecturesByFaculty(int facultyId, {int termId = 1, int year = 2025}) async {
    final response = await _baseApiClient.get(
      LecturesApiEndpoints.lecturesByFaculty(facultyId, termId: termId, year: year),
      version: 1, // Use v1 API
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => LectureDto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load lectures for faculty $facultyId - ${response.statusCode}');
    }
  }
}
