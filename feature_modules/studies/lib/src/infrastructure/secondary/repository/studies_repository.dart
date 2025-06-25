import 'package:shared_api/studies.dart';

import '../../../domain/exception/studies_generic_exception.dart';
import '../../../domain/interface/studies_repository_interface.dart';
import '../data/api/studies_api_client.dart';
import '../data/storage/studies_storage.dart';

class StudiesRepository implements StudiesRepositoryInterface {
  const StudiesRepository(this._apiClient, this._storage);

  final StudiesApiClient _apiClient;
  final StudiesStorage _storage;

  @override
  Future<List<Faculty>> getFaculties({bool forceRefresh = false}) async {
    try {
      final cachedFaculties = await _storage.getFaculties();

      if (cachedFaculties.isNotEmpty && !forceRefresh) {
        return cachedFaculties.map((facultyDto) => facultyDto.toDomain()).toList();
      }
      final retrievedFacultiesData = await _apiClient.getFaculties();
      await _storage.saveFaculites(retrievedFacultiesData);
      return retrievedFacultiesData.map((facultyDto) => facultyDto.toDomain()).toList();
    } catch (e) {
      throw const StudiesGenericException();
    }
  }

  @override
  Future<List<int>> getSelectedFacultyIds() {
    return _storage.getSelectedFaculties();
  }

  @override
  Future<void> saveSelectedFacultyIds(List<int> faculties) {
    return _storage.saveSelectedFaculties(faculties);
  }

  @override
  Future<void> clearSelectedFacultyIds() {
    return _storage.clearSelectedFaculties();
  }
}
