import 'dart:convert';

import 'package:core/api.dart';
import 'feedback_api_endpoints.dart';
import '../dto/user_feedback_dto.dart';

class FeedbackApiClient {
  const FeedbackApiClient(this._baseApiClient);

  final BaseApiClient _baseApiClient;

  Future<void> sendFeedback(UserFeedbackDto feedbackDto) async {
    await _baseApiClient.post(
      FeedbackApiEndpoints.feedback,
      additionalHeaders: {"Content-Type": "application/json"},
      body: jsonEncode(feedbackDto),
    );
  }
}
