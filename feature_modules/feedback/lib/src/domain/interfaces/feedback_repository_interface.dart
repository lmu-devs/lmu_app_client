import '../models/user_feedback.dart';

abstract class FeedbackRepositoryInterface {
  Future<void> sendFeedback(UserFeedback feedback);
}
