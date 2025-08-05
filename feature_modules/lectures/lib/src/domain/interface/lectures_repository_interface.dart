import '../exception/lectures_generic_exception.dart';
import '../model/lecture.dart';

abstract class LecturesRepositoryInterface {
  /// Fetches the latest lectures data from the remote source.
  ///
  /// Throws a [LecturesGenericException] on failure.
  Future<List<Lecture>> getLectures({bool forceRefresh = false});

  /// Retrieves cached lectures data, if available.
  ///
  /// Returns `null` if no cached data exists.
  Future<List<Lecture>?> getCachedLectures();

  /// Deletes any cached lectures data.
  Future<void> deleteLectures();

  /// Fetches lectures for a specific faculty.
  ///
  /// Throws a [LecturesGenericException] on failure.
  Future<List<Lecture>> getLecturesByFaculty(int facultyId);
}
