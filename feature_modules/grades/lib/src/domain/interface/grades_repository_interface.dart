import '../model/grade.dart';

abstract class GradesRepositoryInterface {
  /// Fetches the latest Grades data from the remote source.
  ///
  /// Throws a [GradesGenericException] on failure.
  Future<List<Grade>> getGrades();

  /// Retrieves cached Grades data, if available.
  ///
  /// Returns `null` if no cached data exists.
  Future<List<Grade>?> getCachedGrades();

  /// Saves the provided Grades data to the cache.
  /// /// [grades]: The list of Grades to be cached.
  Future<void> saveGrades(List<Grade> grades);

  /// Deletes any cached Grades data.
  Future<void> deleteGrades();
}
