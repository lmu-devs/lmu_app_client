import '../exception/lectures_generic_exception.dart';
import '../model/lecture.dart';
import '../model/pagination.dart';

abstract class LecturesRepositoryInterface {
  /// Fetches lectures for a specific faculty.
  ///
  /// Throws a [LecturesGenericException] on failure.
  Future<List<Lecture>> getLecturesByFaculty(int facultyId, {int termId = 1, int year = 2025});

  /// Retrieves cached lectures for a specific faculty.
  ///
  /// Returns empty list if no cached data exists.
  Future<List<Lecture>> getCachedLecturesByFaculty(int facultyId, {int termId = 1, int year = 2025});

  // ============================================================================
  // FUTURE IMPROVEMENT: Pagination Support
  // ============================================================================
  // The following methods are implemented but currently UNUSED.
  // They are prepared for future UI integration when pagination controls are added.
  // Currently, the UI loads all lectures at once using getLecturesByFaculty().
  //
  // TODO: Integrate pagination into UI when implementing:
  // - Page navigation controls (Previous/Next buttons)
  // - Page size selector (10, 20, 50, 100 items per page)
  // - Infinite scroll or "Load More" functionality
  // - Page indicators (Page X of Y)
  // ============================================================================

  /// Fetches paginated lectures for a specific faculty.
  ///
  /// Throws a [LecturesGenericException] on failure.
  ///
  /// FUTURE IMPROVEMENT: Currently unused - UI integration pending
  Future<PaginatedResult<Lecture>> getLecturesByFacultyPaginated(
    int facultyId, {
    PaginationConfig pagination = const PaginationConfig(),
    int termId = 1,
    int year = 2025,
  });

  /// Retrieves cached paginated lectures for a specific faculty.
  ///
  /// Returns empty result if no cached data exists.
  ///
  /// FUTURE IMPROVEMENT: Currently unused - UI integration pending
  Future<PaginatedResult<Lecture>?> getCachedLecturesByFacultyPaginated(
    int facultyId, {
    PaginationConfig pagination = const PaginationConfig(),
    int termId = 1,
    int year = 2025,
  });
}
