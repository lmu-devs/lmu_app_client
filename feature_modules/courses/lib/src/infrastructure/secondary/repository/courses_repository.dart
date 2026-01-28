import '../../../domain/interface/courses_repository_interface.dart';
import '../../../domain/model/available_semesters_model.dart';
import '../../../domain/model/course_details_model.dart';
import '../../../domain/model/course_model.dart';
import '../../../domain/exception/courses_generic_exception.dart';
import '../data/api/courses_api_client.dart';

class CoursesRepository implements CoursesRepositoryInterface {
  const CoursesRepository(this._apiClient);

  final CoursesApiClient _apiClient;

  @override
  Future<AvailableSemestersModel> getAvailableSemesters() async {
    try {
      final wrapper = await _apiClient.getAvailableSemesters();
      return wrapper.toDomain();
    } catch (e) {
      throw const CoursesGenericException();
    }
  }

  @override
  Future<List<CourseModel>> getCourses(int facultyId, String semesterType, int year) async {
    try {
      final wrapper = await _apiClient.getCourses(facultyId, semesterType, year);
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
