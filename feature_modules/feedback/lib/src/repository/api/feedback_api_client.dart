import 'dart:convert';

import 'package:core/api.dart';
import 'package:feedback/src/repository/api/feedback_api_endpoints.dart';
import 'package:get_it/get_it.dart';

import 'models/feedback_model.dart';

class FeedbackApiClient {
  final _baseApiClient = GetIt.I.get<BaseApiClient>();

  Future<void> saveFeedback({required FeedbackModel feedbackModel}) async {
    await _baseApiClient.post(
      FeedbackApiEndpoints.saveFeedback(),
      additionalHeaders: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(feedbackModel),
    );
  }
}
