import '../../../domain/exception/lectures_generic_exception.dart';
import '../../../domain/interface/lectures_repository_interface.dart';
import '../../../domain/model/lecture.dart';
import '../data/dto/lectures_dto.dart';
import '../data/storage/lectures_storage.dart';

class LecturesRepository implements LecturesRepositoryInterface {
  const LecturesRepository(this._storage);

  final LecturesStorage _storage;

  @override
  Future<List<Lecture>> getLectures() async {
    try {
      // For now, return mock data since API is not implemented
      final mockLectures = _getMockLectures();
      
      // Save to cache for future use
      await _saveLecturesToCache(mockLectures);
      return mockLectures;

      // TODO: Uncomment when API is ready
      // final retrievedLecturesData = await _apiClient.getLectures();
      // await _storage.saveLectures(retrievedLecturesData);
      // return LecturesDto.toDomainList(retrievedLecturesData);
    } catch (e) {
      throw const LecturesGenericException();
    }
  }

  @override
  Future<List<Lecture>?> getCachedLectures() async {
    final cachedLecturesData = await _storage.getLectures();
    if (cachedLecturesData == null) return null;
    try {
      return LecturesDto.toDomainList(cachedLecturesData);
    } catch (e) {
      deleteLectures();
      return null;
    }
  }

  @override
  Future<void> deleteLectures() async {
    await _storage.deleteLectures();
  }

  // Helper method to save lectures to cache efficiently
  Future<void> _saveLecturesToCache(List<Lecture> lectures) async {
    try {
      // Convert to DTOs only when saving to cache
      final dtos = lectures.map((lecture) => LecturesDto(
        id: lecture.id,
        title: lecture.title,
        tags: lecture.tags,
        facultyId: lecture.facultyId,
        description: lecture.description,
        credits: lecture.credits,
        semester: lecture.semester,
      )).toList();
      
      await _storage.saveLectures(dtos);
    } catch (e) {
      // Cache save failed, but don't throw - data is still available
    }
  }

  // Mock data for testing
  List<Lecture> _getMockLectures() {
    return [
      Lecture(
        id: '1',
        title: 'Credit Risk Modelling',
        tags: ['VL', '6 SWS', 'Master', 'English'],
        facultyId: 1,
      ),
      Lecture(
        id: '2',
        title: 'Cybersecurity',
        tags: ['VL', '4 SWS', 'Bachelor', 'German'],
        facultyId: 1,
      ),
      Lecture(
        id: '3',
        title: 'Game Development',
        tags: ['VL', '8 SWS', 'Master', 'English'],
        facultyId: 1,
      ),
      Lecture(
        id: '4',
        title: 'Machine Learning',
        tags: ['VL', '6 SWS', 'Master', 'English'],
        facultyId: 2,
      ),
      Lecture(
        id: '5',
        title: 'Data Structures',
        tags: ['VL', '4 SWS', 'Bachelor', 'German'],
        facultyId: 2,
      ),
    ];
  }
}
