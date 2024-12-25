import 'dart:convert';

import 'package:feedback/src/repository/api/feedback_api_endpoints.dart';
import 'package:http/http.dart' as http;

import 'models/feedback_model.dart';

class FeedbackApiClient {
  Future<void> saveFeedback({required String userApiKey, required FeedbackModel feedbackModel}) async {
    try {
      final response = await http.post(
        Uri.parse(FeedbackApiEndpoints.saveFeedback()),
        headers: {
          "Content-Type": "application/json",
          "user-api-key": userApiKey,
        },
        body: jsonEncode(feedbackModel),
      );

      if (response.statusCode == 200) {
        final type = feedbackModel.type;
        print('${type[0].toUpperCase()}${type.substring(1).toLowerCase()} successfully submitted');
      } else {
        throw Exception('Failed to submit feedback');
      }
    } catch (e) {
      rethrow;
    }
  }
}
