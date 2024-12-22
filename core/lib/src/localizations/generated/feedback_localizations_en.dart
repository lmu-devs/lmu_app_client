import 'feedback_localizations.dart';

/// The translations for English (`en`).
class FeedbackLocalizationsEn extends FeedbackLocalizations {
  FeedbackLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get feedbackTitle => 'Feedback';

  @override
  String get feedbackDescription => 'How\'s your experience with the app?';

  @override
  String get feedbackButton => 'Send Feedback';

  @override
  String get feedbackSuccess => 'Feedback sent';

  @override
  String get feedbackError => 'Your feedback couldn\'t be submitted';

  @override
  String get feedbackInputHint => 'Tell us more sweetie ...';

  @override
  String get bugTitle => 'Report a Bug';

  @override
  String get bugDescription => 'Have you discovered a bug? Let us know! Your feedback helps us improve the app.';

  @override
  String get bugInputHint => 'I had a bug where ...';

  @override
  String get bugButton => 'Report Bug';

  @override
  String get bugSuccess => 'Bug reported';

  @override
  String get bugError => 'Your bug couldn\'t be submitted';

  @override
  String get suggestionTitle => 'Suggest a Feature';

  @override
  String get suggestionDescription => 'No matter whether small, big, crazy, complicated, boring or visionary – share your ideas with us here.';

  @override
  String get suggestionInputHint => 'I wish the app had ...';

  @override
  String get suggestionButton => 'Send Suggestion';

  @override
  String get suggestionSuccess => 'Suggestion sent';

  @override
  String get suggestionError => 'Your suggestion couldn\'t be submitted';
}
