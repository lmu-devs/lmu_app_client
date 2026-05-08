import '../model/semester_course.dart';

abstract class DeveloperdexRepositoryInterface {
  List<SemesterCourse> getSemesterCourses();

  Future<List<String>> getSeenEntries();

  Future<void> saveSeenDeleoperdexIds(List<String> developerdexIds);

  /// Deletes any cached Developerdex data.
  Future<void> deleteDeveloperdex();
}
