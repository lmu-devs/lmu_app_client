import 'package:feedback/src/repository/api/api.dart';

import 'api/models/feedback_model.dart';

abstract class FeedbackRepository {
  Future<void> saveFeedback(FeedbackModel feedbackModel);
}

class ConnectedFeedbackRepository implements FeedbackRepository {
  ConnectedFeedbackRepository({
    required this.feedbackApiClient,
  });

  final FeedbackApiClient feedbackApiClient;

  /// Function to save feedback data to the backend
  @override
  Future<void> saveFeedback(FeedbackModel feedbackModel) async {
    try {
      await feedbackApiClient.saveFeedback(feedbackModel: feedbackModel);
    } catch (e) {
      rethrow;
    }
  }
}
