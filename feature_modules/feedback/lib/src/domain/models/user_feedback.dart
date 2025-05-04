import 'package:shared_api/feedback.dart';

import 'emoji_feedback.dart';

class UserFeedback {
  const UserFeedback({
    required this.type,
    required this.screen,
    this.rating,
    this.message,
  });

  final FeedbackType type;
  final String screen;
  final EmojiFeedback? rating;
  final String? message;
}
