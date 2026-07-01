import '../../../domain/exception/grades_generic_exception.dart';
import '../../../domain/interface/grades_repository_interface.dart';
import '../../../domain/model/grade.dart';
import '../data/dto/grade_dto.dart';
import '../data/storage/grades_storage.dart';

class GradesRepository implements GradesRepositoryInterface {
  const GradesRepository(this._storage);

  final GradesStorage _storage;

  @override
  Future<List<Grade>> getGrades() async {
    try {
      return await getCachedGrades() ?? [];
    } catch (e) {
      throw const GradesGenericException();
    }
  }

  @override
  Future<List<Grade>?> getCachedGrades() async {
    final cachedGradesData = await _storage.getGrades();
    if (cachedGradesData == null) return null;
    try {
      return cachedGradesData.map((dto) => dto.toDomain()).toList();
    } catch (e) {
      deleteGrades();
      return null;
    }
  }

  @override
  Future<void> deleteGrades() async {
    await _storage.deleteGrades();
  }

  @override
  Future<void> saveGrades(List<Grade> grades) {
    final gradeDtos = grades.map((grade) => GradeDto.fromDomain(grade)).toList();
    return _storage.saveGrades(gradeDtos);
  }

  @override
  Future<double?> getTotalEcts() {
    return _storage.getTotalEcts();
  }

  @override
  Future<void> saveTotalEcts(double totalEcts) {
    return _storage.saveTotalEcts(totalEcts);
  }

  @override
  Future<void> deleteTotalEcts() {
    return _storage.deleteTotalEcts();
  }
}
