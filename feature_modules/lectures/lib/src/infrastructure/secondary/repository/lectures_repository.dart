import 'package:flutter/foundation.dart';

import '../../../domain/interface/lectures_repository_interface.dart';
import '../../../domain/model/lecture.dart';
import '../../../domain/model/pagination.dart';
import '../../../domain/utils/error_handler.dart';
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
      try {
        await _storage.saveLecturesByFaculty(facultyId, lecturesData);
      } catch (e) {
        // Log cache error but don't fail the request
        debugPrint('Failed to cache lectures for faculty $facultyId: $e');
      }

      return lecturesData.map((dto) => dto.toDomain(facultyId: facultyId, termId: termId, year: year)).toList();
    } catch (e) {
      ErrorHandler.logError(e, 'API call for faculty $facultyId');

      // If API fails, try to get from cache
      try {
        final cachedData = await _storage.getLecturesByFaculty(facultyId);
        if (cachedData != null && cachedData.isNotEmpty) {
          return cachedData.map((dto) => dto.toDomain(facultyId: facultyId, termId: termId, year: year)).toList();
        }
      } catch (cacheError) {
        ErrorHandler.logError(cacheError, 'Cache retrieval for faculty $facultyId');
      }

      // Re-throw with consistent error handling
      throw ErrorHandler.handleApiError(e, 'Failed to load lectures for faculty $facultyId');
    }
  }

  // ============================================================================
  // FUTURE IMPROVEMENT: Pagination Support
  // ============================================================================
  // The following methods are implemented but currently UNUSED.
  // They are prepared for future UI integration when pagination controls are added.
  // Currently, the UI loads all lectures at once using getLecturesByFaculty().
  // ============================================================================

  @override
  Future<PaginatedResult<Lecture>> getLecturesByFacultyPaginated(
    int facultyId, {
    PaginationConfig pagination = const PaginationConfig(),
    int termId = 1,
    int year = 2025,
  }) async {
    try {
      // FUTURE IMPROVEMENT: Currently unused - UI integration pending
      // For now, get all lectures and paginate locally
      // TODO: Implement server-side pagination when API supports it
      final allLectures = await getLecturesByFaculty(facultyId, termId: termId, year: year);
      
      final startIndex = pagination.offset;
      final endIndex = (startIndex + pagination.pageSize).clamp(0, allLectures.length);
      
      final paginatedData = allLectures.sublist(
        startIndex.clamp(0, allLectures.length),
        endIndex,
      );
      
      return PaginatedResult<Lecture>(
        data: paginatedData,
        pagination: pagination,
        hasMore: endIndex < allLectures.length,
        totalCount: allLectures.length,
      );
    } catch (e) {
      throw ErrorHandler.handleApiError(e, 'Failed to load paginated lectures for faculty $facultyId');
    }
  }

  @override
  Future<List<Lecture>> getCachedLecturesByFaculty(int facultyId, {int termId = 1, int year = 2025}) async {
    final cachedData = await _storage.getLecturesByFaculty(facultyId);
    if (cachedData == null) return [];
    return cachedData.map((dto) => dto.toDomain(facultyId: facultyId, termId: termId, year: year)).toList();
  }

  @override
  Future<PaginatedResult<Lecture>?> getCachedLecturesByFacultyPaginated(
    int facultyId, {
    PaginationConfig pagination = const PaginationConfig(),
    int termId = 1,
    int year = 2025,
  }) async {
    try {
      // FUTURE IMPROVEMENT: Currently unused - UI integration pending
      final allCachedLectures = await getCachedLecturesByFaculty(facultyId, termId: termId, year: year);
      if (allCachedLectures.isEmpty) return null;
      
      final startIndex = pagination.offset;
      final endIndex = (startIndex + pagination.pageSize).clamp(0, allCachedLectures.length);
      
      final paginatedData = allCachedLectures.sublist(
        startIndex.clamp(0, allCachedLectures.length),
        endIndex,
      );
      
      return PaginatedResult<Lecture>(
        data: paginatedData,
        pagination: pagination,
        hasMore: endIndex < allCachedLectures.length,
        totalCount: allCachedLectures.length,
      );
    } catch (e) {
      ErrorHandler.logError(e, 'Cache pagination for faculty $facultyId');
      return null;
    }
  }
}
