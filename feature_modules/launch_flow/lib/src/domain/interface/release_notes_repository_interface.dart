import '../model/release_notes.dart';

abstract class ReleaseNotesRepositoryInterface {
  Future<ReleaseNotes> getReleaseNotes();

  Future<bool> shouldShowReleaseNotes();

  Future<void> markReleaseNotesAsShown();
}
