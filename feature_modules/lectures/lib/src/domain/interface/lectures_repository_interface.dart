import '../exception/lectures_generic_exception.dart';
import '../model/lecture.dart';

abstract class LecturesRepositoryInterface {
  /// Fetches lectures for a specific faculty.
  ///
  /// Throws a [LecturesGenericException] on failure.
  Future<List<Lecture>> getLecturesByFaculty(int facultyId, {int termId = 1, int year = 2025});

  /// Retrieves cached lectures for a specific faculty.
  ///
  /// Returns empty list if no cached data exists.
  Future<List<Lecture>> getCachedLecturesByFaculty(int facultyId, {int termId = 1, int year = 2025});
}
