enum FeedbackType {
  general,
  bug,
  suggestion,
}

extension FeedbackTypeExtension on FeedbackType {
  String getValue() {
    switch (this) {
      case FeedbackType.general:
        return 'GENERAL';
      case FeedbackType.bug:
        return 'BUG';
      case FeedbackType.suggestion:
        return 'SUGGESTION';
    }
  }
}
