import '../model/course_model.dart';

abstract class CoursesRepositoryInterface {
  /// Fetches the latest Courses data from the remote source.
  ///
  /// Throws a [DomainException] on failure.
  Future<List<CourseModel>> getCourses(int facultyId);
}
