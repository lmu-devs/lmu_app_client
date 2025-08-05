import 'dart:convert';

import 'package:core/api.dart';

import '../../../../domain/exception/lectures_generic_exception.dart';
import '../dto/course_dto.dart';
import '../dto/lectures_dto.dart';
import 'lectures_api_endpoints.dart';

class LecturesApiClient {
  const LecturesApiClient(this._baseApiClient);

  final BaseApiClient _baseApiClient;

  Future<LecturesDto> getLectures() async {
    final response = await _baseApiClient.get(LecturesApiEndpoints.lectures);
    return LecturesDto.fromJson(jsonDecode(response.body));
  }

  Future<List<CourseDto>> getCoursesByFaculty(int facultyId) async {
    if (facultyId <= 0) {
      throw const LecturesGenericException();
    }
    
    final response = await _baseApiClient.get(LecturesApiEndpoints.courseByFaculty(facultyId));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => CourseDto.fromJson(json)).toList();
    } else {
      throw const LecturesGenericException();
    }
  }
}
