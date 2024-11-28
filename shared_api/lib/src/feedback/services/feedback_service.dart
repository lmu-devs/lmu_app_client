import 'package:flutter/material.dart';

abstract class FeedbackService {
  void navigateToFeedback(BuildContext context);
  void navigateToBugReport(BuildContext context);
  void navigateToSuggestion(BuildContext context);
}
