enum FeedbackType {
  general,
  bug,
  suggestion,
}

class FeedbackArgs {
  const FeedbackArgs({
    required this.origin,
    required this.type,
    this.title,
    this.description,
    this.inputHint,
    this.buttonTitle,
  });

  final String origin;
  final FeedbackType type;
  final String? title;
  final String? description;
  final String? inputHint;
  final String? buttonTitle;
}
