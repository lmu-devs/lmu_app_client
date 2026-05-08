import 'package:flutter/material.dart';

import '../../domain/interface/release_notes_repository_interface.dart';
import '../../domain/model/release_notes_highlight.dart';

class GetReleaseNotesUsecase extends ChangeNotifier {
  GetReleaseNotesUsecase(this._repository);

  final ReleaseNotesRepositoryInterface _repository;

  List<ReleaseNotesHighlight> _releaseNotesHighlights = [];
  bool _showPrivacyPolicy = false;

  List<ReleaseNotesHighlight> get releaseNotesHighlights => _releaseNotesHighlights;
  bool get showPrivacyPolicy => _showPrivacyPolicy;

  Future<bool> loadReleaseNotes() async {
    final shouldShow = await _repository.shouldShowReleaseNotes();
    if (!shouldShow) return false;

    try {
      final releaseNotes = await _repository.getReleaseNotes();
      _releaseNotesHighlights = releaseNotes.highlights;
      _showPrivacyPolicy = releaseNotes.showPrivacyPolicy;
      if (_releaseNotesHighlights.isNotEmpty) return true;
    } catch (_) {
      _releaseNotesHighlights = [];
      _showPrivacyPolicy = false;
    }
    notifyListeners();

    return false;
  }
}
