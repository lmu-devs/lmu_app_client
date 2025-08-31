import '../exception/lectures_generic_exception.dart';
import '../model/course.dart';
import '../model/lectures.dart';

abstract class LecturesRepositoryInterface {
  /// Fetches the latest Lectures data from the remote source.
  ///
  /// Throws a [LecturesGenericException] on failure.
  Future<Lectures> getLectures();

  /// Retrieves cached Lectures data, if available.
  ///
  /// Returns `null` if no cached data exists.
  Future<Lectures?> getCachedLectures();

  /// Deletes any cached Lectures data.
  Future<void> deleteLectures();

  /// Fetches courses for a specific faculty.
  ///
  /// Throws a [LecturesGenericException] on failure.
  Future<List<Course>> getCoursesByFaculty(int facultyId);
}
