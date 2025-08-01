import '../../../domain/interface/developerdex_repository_interface.dart';
import '../../../domain/model/semester_course.dart';
import '../data/semester_courses.dart';
import '../data/storage/developerdex_storage.dart';

class DeveloperdexRepository implements DeveloperdexRepositoryInterface {
  const DeveloperdexRepository(this._storage);

  final DeveloperdexStorage _storage;

  @override
  List<SemesterCourse> getSemesterCourses() => semesterCourses;

  @override
  Future<List<String>> getSeenEntries() async {
    final seenEntries = await _storage.getSeenEntries();
    return seenEntries ?? [];
  }

  @override
  Future<void> saveSeenDeleoperdexIds(List<String> developerdexIds) {
    return _storage.saveSeenEntries(developerdexIds);
  }

  @override
  Future<void> deleteDeveloperdex() async => await _storage.deleteSeenEntries();
}
