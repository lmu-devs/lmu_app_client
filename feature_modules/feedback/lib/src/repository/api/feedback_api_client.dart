import 'dart:convert';

import 'package:core/api.dart';
import 'package:feedback/src/repository/api/feedback_api_endpoints.dart';
import 'package:get_it/get_it.dart';

import 'models/feedback_model.dart';

class FeedbackApiClient {
  final _baseApiClient = GetIt.I.get<BaseApiClient>();

  Future<void> saveFeedback({required FeedbackModel feedbackModel}) async {
    try {
      final response = await _baseApiClient.post(
        FeedbackApiEndpoints.saveFeedback(),
        additionalHeaders: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(feedbackModel),
      );

      if (response.statusCode == 200) {
        final type = feedbackModel.type;
        print('${type[0].toUpperCase()}${type.substring(1).toLowerCase()} feedback successfully submitted');
      } else {
        throw Exception('Failed to submit feedback - ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to submit feedback - $e');
    }
  }
}
