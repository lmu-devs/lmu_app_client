import '../../../../domain/model/release_notes.dart';
import '../../../../domain/model/release_notes_highlight.dart';
import 'release_notes_dto.dart';
import 'release_notes_highlight_dto.dart';

class ReleaseNotesMapper {
  static ReleaseNotes toDomain(RelaseNotesDto dto) {
    return ReleaseNotes(
      showPrivacyPolicy: dto.showPrivacyPolicy,
      highlights: dto.highlights.map((highlight) => ReleaseNotesHighlightMapper.toDomain(highlight)).toList(),
    );
  }
}

class ReleaseNotesHighlightMapper {
  static ReleaseNotesHighlight toDomain(ReleaseNotesHighlightDto dto) {
    return ReleaseNotesHighlight(
      emoji: dto.emoji,
      title: dto.title,
      description: dto.description,
    );
  }
}
