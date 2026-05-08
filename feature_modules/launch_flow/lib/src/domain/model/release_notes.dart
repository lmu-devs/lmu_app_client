import 'release_notes_highlight.dart';

class ReleaseNotes {
  const ReleaseNotes({
    required this.showPrivacyPolicy,
    required this.highlights,
  });

  final bool showPrivacyPolicy;
  final List<ReleaseNotesHighlight> highlights;
}
