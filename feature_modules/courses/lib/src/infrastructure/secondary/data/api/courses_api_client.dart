import 'dart:convert';

import 'package:core/api.dart';

import '../dto/course_dto.dart';
import '../dto/courses_list_wrapper_dto.dart';
import 'courses_api_endpoints.dart';

class CoursesApiClient {
  const CoursesApiClient(this._baseApiClient);

  final BaseApiClient _baseApiClient;

  Future<CoursesListWrapperDto> getCourses(int facultyId) async {
    final response = await _baseApiClient.get(CoursesApiEndpoints.coursesByFaculty(facultyId));

      final List<dynamic> data = json.decode(response.body);
      final courses = data.map((json) => CourseDto.fromJson(json)).toList();

    return CoursesListWrapperDto(
      courses: courses,
      totalCount: courses.length,
      pageSize: courses.length,
      currentPage: 1,
    );
  }
}
