import '../model/course_details_model.dart';
import '../model/course_model.dart';

abstract class CoursesRepositoryInterface {
  /// Fetches courses data for a specified faculty.
  ///
  /// Throws a [DomainException] on failure.
  Future<List<CourseModel>> getCourses(int facultyId);

  /// Fetches course details data for a specified course using the course id.
  ///
  /// Throws a [DomainException] on failure.
  Future<CourseDetailsModel> getCourseDetails(int courseId);
}
