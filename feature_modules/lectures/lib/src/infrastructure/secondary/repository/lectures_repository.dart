import 'package:core/logging.dart';

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
  Future<List<Lecture>> getLectures({bool forceRefresh = false}) async {
    try {
      final cachedLectures = await _storage.getLectures();

      if (cachedLectures != null && !forceRefresh) {
        return [cachedLectures.toDomain()];
      }

      final retrievedLecturesData = await _apiClient.getLectures();
      await _storage.saveLectures(retrievedLecturesData);
      return [retrievedLecturesData.toDomain()];
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
      AppLogger().logMessage("[LecturesRepository]: Loaded ${coursesData.length} courses for faculty $facultyId");
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
      AppLogger().logError("[LecturesRepository]: Failed to load courses for faculty $facultyId", error: e);
      throw const LecturesGenericException();
    }
  }
}
