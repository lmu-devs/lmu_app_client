import 'package:feedback/src/pages/pages.dart';
import 'package:flutter/widgets.dart';
import 'package:core/components.dart';
import 'package:shared_api/feedback.dart';

class DefaultFeedbackService implements FeedbackService {
  @override
  void navigateToFeedback(BuildContext context, String feedbackOrigin) {
    LmuBottomSheet.showExtended(
      context,
      content: FeedbackModal(feedbackOrigin: feedbackOrigin),
    );
  }

  @override
  void navigateToBugReport(BuildContext context, String feedbackOrigin) {
    LmuBottomSheet.showExtended(
      context,
      content: BugModal(feedbackOrigin: feedbackOrigin),
    );
  }

  @override
  void navigateToSuggestion(BuildContext context, String feedbackOrigin) {
    LmuBottomSheet.showExtended(
      context,
      content: SuggestionModal(feedbackOrigin: feedbackOrigin),
    );
  }
}
