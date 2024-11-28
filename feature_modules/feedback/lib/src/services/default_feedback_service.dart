import 'package:feedback/src/pages/pages.dart';
import 'package:flutter/widgets.dart';
import 'package:core/components.dart';
import 'package:shared_api/feedback.dart';

class DefaultFeedbackService implements FeedbackService {
  @override
  void navigateToFeedback(BuildContext context) {
    LmuBottomSheet.showExtended(
      context,
      content: const FeedbackModal(),
    );
  }
  @override
  void navigateToBugReport(BuildContext context) {
    LmuBottomSheet.showExtended(
      context,
      content: const BugModal(),
    );
  }
  @override
  void navigateToSuggestion(BuildContext context) {
    LmuBottomSheet.showExtended(
      context,
      content: const SuggestionModal(),
    );
  }
}
