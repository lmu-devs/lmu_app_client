import 'package:flutter/material.dart';

abstract class FeedbackService {
  void navigateToFeedback(BuildContext context, String feedbackOrigin);
  void navigateToBugReport(BuildContext context, String feedbackOrigin);
  void navigateToSuggestion(BuildContext context, String feedbackOrigin);
}
