import 'dart:convert';

import 'package:core/api.dart';

import '../dto/course_dto.dart';
import '../dto/lectures_dto.dart';
import 'lectures_api_endpoints.dart';

class LecturesApiClient {
  const LecturesApiClient(this._baseApiClient);

  final BaseApiClient _baseApiClient;

  Future<LecturesDto> getLectures() async {
    return const LecturesDto(id: "1234234", name: "Natural Computing");
    // ignore: dead_code
    final response = await _baseApiClient.get(LecturesApiEndpoints.lectures);
    return LecturesDto.fromJson(jsonDecode(response.body));
  }

  Future<List<CourseDto>> getCoursesByFaculty(int facultyId) async {
    final response = await _baseApiClient.get(LecturesApiEndpoints.courseByFaculty(facultyId));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => CourseDto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load courses for faculty $facultyId - ${response.statusCode}');
    }
  }
}
