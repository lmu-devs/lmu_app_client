import 'package:core/api.dart';

import '../../../../domain/exception/lectures_generic_exception.dart';
import '../dto/course_dto.dart';
import '../dto/lectures_dto.dart';

class LecturesApiClient {
  const LecturesApiClient(this._baseApiClient);

  final BaseApiClient _baseApiClient;

  Future<LecturesDto> getLectures() async {
    // TODO: Remove mock data when server is working
    // Mock data for testing
    return const LecturesDto(
      id: 'natural_computing_general',
      name: 'Natural Computing',
    );

    // Original API call (commented out until server is fixed)
    // final response = await _baseApiClient.get(LecturesApiEndpoints.lectures);
    // return LecturesDto.fromJson(jsonDecode(response.body));
  }

  Future<List<CourseDto>> getCoursesByFaculty(int facultyId) async {
    if (facultyId <= 0) {
      throw const LecturesGenericException();
    }

    // TODO: Remove mock data when server is working
    // Mock data for testing - Natural Computing for each faculty
    return [
      CourseDto(
        id: 'natural_computing_$facultyId',
        name: 'Natural Computing',
        facultyId: facultyId,
        description:
            'This course explores computational methods inspired by natural systems, including neural networks, genetic algorithms, and evolutionary computation.',
        credits: 6,
        semester: 'Winter 25/26',
      ),
      CourseDto(
        id: 'machine_learning_$facultyId',
        name: 'Machine Learning',
        facultyId: facultyId,
        description: 'Introduction to machine learning algorithms and their applications in data science.',
        credits: 8,
        semester: 'Winter 25/26',
      ),
      CourseDto(
        id: 'data_structures_$facultyId',
        name: 'Data Structures & Algorithms',
        facultyId: facultyId,
        description: 'Fundamental data structures and algorithms for efficient problem solving.',
        credits: 6,
        semester: 'Winter 25/26',
      ),
    ];

    // Original API call (commented out until server is fixed)
    // final response = await _baseApiClient.get(LecturesApiEndpoints.courseByFaculty(facultyId));
    //
    // if (response.statusCode == 200) {
    //   final List<dynamic> data = json.decode(response.body);
    //   return data.map((json) => CourseDto.fromJson(json)).toList();
    // } else {
    //   throw const LecturesGenericException();
    // }
  }
}
