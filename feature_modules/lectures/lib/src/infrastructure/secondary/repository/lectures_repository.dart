import '../../../domain/exception/lectures_generic_exception.dart';
import '../../../domain/interface/lectures_repository_interface.dart';
import '../../../domain/model/course.dart';
import '../../../domain/model/lectures.dart';
import '../data/api/lectures_api_client.dart';
import '../data/storage/lectures_storage.dart';

class LecturesRepository implements LecturesRepositoryInterface {
  const LecturesRepository(this._apiClient, this._storage);

  final LecturesApiClient _apiClient;
  final LecturesStorage _storage;

  @override
  Future<Lectures> getLectures() async {
    try {
      final retrievedLecturesData = await _apiClient.getLectures();
      await _storage.saveLectures(retrievedLecturesData);
      return retrievedLecturesData.toDomain();
    } catch (e) {
      throw const LecturesGenericException();
    }
  }

  @override
  Future<Lectures?> getCachedLectures() async {
    final cachedLecturesData = await _storage.getLectures();
    if (cachedLecturesData == null) return null;
    try {
      return cachedLecturesData.toDomain();
    } catch (e) {
      deleteLectures();
      return null;
    }
  }

  @override
  Future<void> deleteLectures() async {
    await _storage.deleteLectures();
  }

  @override
  Future<List<Course>> getCoursesByFaculty(int facultyId) async {
    try {
      final coursesData = await _apiClient.getCoursesByFaculty(facultyId);
      return coursesData
          .map((dto) => Course(
                id: dto.id,
                name: dto.name,
                facultyId: dto.facultyId,
                description: dto.description,
                credits: dto.credits,
                semester: dto.semester,
              ))
          .toList();
    } catch (e) {
      throw const LecturesGenericException();
    }
  }
}
