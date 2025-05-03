import 'package:flutter/material.dart';

abstract class FeedbackService {
  void openFeedback(BuildContext context, String feedbackOrigin);
  void openBugReport(BuildContext context, String feedbackOrigin);
  void openSuggestion(BuildContext context, String feedbackOrigin);
  Widget getMissingItemInput(String title, String feedbackOrigin);
}
