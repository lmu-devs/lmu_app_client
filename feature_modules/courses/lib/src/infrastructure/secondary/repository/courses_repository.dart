import '../../../domain/interface/courses_repository_interface.dart';
import '../../../domain/model/course_details_model.dart';
import '../../../domain/model/course_model.dart';
import '../../../domain/exception/courses_generic_exception.dart';
import '../data/api/courses_api_client.dart';

class CoursesRepository implements CoursesRepositoryInterface {
  const CoursesRepository(this._apiClient);

  final CoursesApiClient _apiClient;

  @override
  Future<List<CourseModel>> getCourses(int facultyId) async {
    try {
      final wrapper = await _apiClient.getCourses(facultyId);
      return wrapper.courses.map((dto) => dto.toDomain()).toList();
    } catch (e) {
      throw const CoursesGenericException();
    }
  }

  @override
  Future<CourseDetailsModel> getCourseDetails(int courseId) async {
    try {
      final wrapper = await _apiClient.getCourseDetails(courseId);
      return wrapper.toDomain();
    } catch (e) {
      throw const CoursesGenericException();
    }
  }
}
