import 'package:feedback/src/repository/api/api.dart';
import 'package:shared_api/user.dart';

import 'api/models/feedback_model.dart';

abstract class FeedbackRepository {
  Future<void> saveFeedback(FeedbackModel feedbackModel);
}

class ConnectedFeedbackRepository implements FeedbackRepository {
  ConnectedFeedbackRepository({
    required this.feedbackApiClient,
    required this.userService,
  });

  final FeedbackApiClient feedbackApiClient;
  final UserService userService;

  /// Function to save feedback data to the backend
  @override
  Future<void> saveFeedback(FeedbackModel feedbackModel) async {
    final userApiKey = userService.userApiKey;
    if (userApiKey == null) throw Exception('User api key is null');

    try {
      await feedbackApiClient.saveFeedback(
        userApiKey: userApiKey,
        feedbackModel: feedbackModel,
      );
    } catch (e) {
      rethrow;
    }
  }
}
