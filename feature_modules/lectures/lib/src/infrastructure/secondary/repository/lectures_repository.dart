import '../../../domain/exception/lectures_generic_exception.dart';
import '../../../domain/interface/lectures_repository_interface.dart';
import '../../../domain/model/lecture.dart';
import '../data/api/lectures_api_client.dart';
import '../data/storage/lectures_storage.dart';

class LecturesRepository implements LecturesRepositoryInterface {
  const LecturesRepository(this._apiClient, this._storage);

  final LecturesApiClient _apiClient;
  final LecturesStorage _storage;

  @override
  Future<List<Lecture>> getLecturesByFaculty(int facultyId, {int termId = 1, int year = 2025}) async {
    try {
      // Try to get from API first
      final lecturesData = await _apiClient.getLecturesByFaculty(facultyId, termId: termId, year: year);

      // Cache the data
      await _storage.saveLecturesByFaculty(facultyId, lecturesData);

      return lecturesData.map((dto) => dto.toDomain(facultyId: facultyId, termId: termId, year: year)).toList();
    } catch (e) {
      // If API fails, try to get from cache
      final cachedData = await _storage.getLecturesByFaculty(facultyId);
      if (cachedData != null) {
        return cachedData.map((dto) => dto.toDomain(facultyId: facultyId, termId: termId, year: year)).toList();
      }
      throw const LecturesGenericException();
    }
  }

  Future<List<Lecture>> getCachedLecturesByFaculty(int facultyId, {int termId = 1, int year = 2025}) async {
    final cachedData = await _storage.getLecturesByFaculty(facultyId);
    if (cachedData == null) return [];
    return cachedData.map((dto) => dto.toDomain(facultyId: facultyId, termId: termId, year: year)).toList();
  }
}
