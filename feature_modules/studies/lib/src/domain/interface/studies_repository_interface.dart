import 'package:shared_api/studies.dart';

abstract class StudiesRepositoryInterface {
  Future<List<Faculty>> getFaculties({bool forceRefresh = false});

  Future<void> saveSelectedFacultyIds(List<int> faculties);

  Future<List<int>> getSelectedFacultyIds();

  Future<void> clearSelectedFacultyIds();
}
