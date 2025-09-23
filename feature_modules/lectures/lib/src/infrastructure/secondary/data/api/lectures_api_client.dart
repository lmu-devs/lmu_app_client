import 'dart:convert';

import 'package:core/api.dart';

import '../../../../domain/exception/lectures_generic_exception.dart';
import '../dto/lecture_dto.dart';
import 'lectures_api_endpoints.dart';

class LecturesApiClient {
  const LecturesApiClient(this._baseApiClient);

  final BaseApiClient _baseApiClient;

  Future<List<LectureDto>> getLecturesByFaculty(int facultyId, {int termId = 1, int year = 2025}) async {
    try {
      final response = await _baseApiClient.get(
        LecturesApiEndpoints.lecturesByFaculty(facultyId, termId: termId, year: year),
        version: 1, // Use v1 API
      );

      if (response.statusCode == 200) {
        try {
          final List<dynamic> data = json.decode(response.body);
          return data.map((json) => LectureDto.fromJson(json)).toList();
        } catch (e) {
          throw LecturesGenericException('Failed to parse lectures data: ${e.toString()}');
        }
      } else {
        throw LecturesGenericException('API request failed with status ${response.statusCode}');
      }
    } catch (e) {
      if (e is LecturesGenericException) {
        rethrow;
      }
      throw LecturesGenericException('Network error: ${e.toString()}');
    }
  }
}
