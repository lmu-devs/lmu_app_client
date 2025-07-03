import '../../../domain/error/release_notes_generic_error.dart';
import '../../../domain/interface/release_notes_repository_interface.dart';
import '../../../domain/model/release_notes.dart';
import '../data/api/release_notes_api_client.dart';
import '../data/dto/release_notes_mapper.dart';
import '../data/storage/release_notes_storage.dart';

class ReleaseNotesRepository implements ReleaseNotesRepositoryInterface {
  const ReleaseNotesRepository(this._apiClient, this._storage, this._appVersion);

  final ReleaseNotesApiClient _apiClient;
  final ReleaseNotesStorage _storage;
  final String _appVersion;

  @override
  Future<ReleaseNotes> getReleaseNotes() async {
    try {
      final data = await _apiClient.getReleaseNotes(version: _appVersion);
      return ReleaseNotesMapper.toDomain(data);
    } catch (e) {
      throw ReleaseNotesGenericError(e.toString());
    }
  }

  @override
  Future<void> markReleaseNotesAsShown() {
    return _storage.saveShowedReleaseNotes(version: _appVersion);
  }

  @override
  Future<bool> shouldShowReleaseNotes() {
    return _storage.shouldShowReleaseNotes(version: _appVersion);
  }
}
