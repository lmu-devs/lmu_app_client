import 'package:core/components.dart';
import 'package:feedback/src/pages/pages.dart';
import 'package:feedback/src/widgets/missing_item_input.dart';
import 'package:flutter/widgets.dart';
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

  @override
  Widget getMissingItemInput(String title, String feedbackOrigin) {
    return MissingItemInput(title: title, feedbackOrigin: feedbackOrigin);
  }
}
