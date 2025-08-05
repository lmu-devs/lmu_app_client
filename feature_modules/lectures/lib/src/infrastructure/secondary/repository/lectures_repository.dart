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
  Future<List<Lecture>> getLectures() async {
    try {
      // For now, return mock data since API is not implemented
      return _getMockLectures();

      // TODO: Uncomment when API is ready
      // final retrievedLecturesData = await _apiClient.getLectures();
      // await _storage.saveLectures(retrievedLecturesData);
      // return retrievedLecturesData.toDomain();
    } catch (e) {
      throw const LecturesGenericException();
    }
  }

  @override
  Future<List<Lecture>?> getCachedLectures() async {
    final cachedLecturesData = await _storage.getLectures();
    if (cachedLecturesData == null) return null;
    try {
      // Since we're storing a single LecturesDto, convert it to a list
      return [cachedLecturesData.toDomain()];
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
  Future<List<Lecture>> getLecturesByFaculty(int facultyId) async {
    try {
      final coursesData = await _apiClient.getCoursesByFaculty(facultyId);
      return coursesData
          .map((dto) => Lecture(
                id: dto.id,
                title: dto.name,
                tags: [], // CourseDto doesn't have tags, using empty list as default
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
