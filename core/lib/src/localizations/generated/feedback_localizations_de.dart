import 'feedback_localizations.dart';

/// The translations for German (`de`).
class FeedbackLocalizationsDe extends FeedbackLocalizations {
  FeedbackLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get feedbackTitle => 'Feedback';

  @override
  String get feedbackDescription => 'Wie ist Deine Erfahrung mit der App?';

  @override
  String get feedbackButton => 'Feedback senden';

  @override
  String get feedbackSuccess => 'Feedback gesendet';

  @override
  String get feedbackError => 'Feedback konnte nicht gesendet werden';

  @override
  String get feedbackInputHint => 'Erzähl uns mehr ...';

  @override
  String get bugTitle => 'Fehler melden';

  @override
  String get bugDescription => 'Du hast einen Fehler entdeckt? Lass es uns wissen! Dein Feedback hilft uns, die App zu verbessern.';

  @override
  String get bugInputHint => 'Ich hatte einen Fehler bei ...';

  @override
  String get bugButton => 'Fehler melden';

  @override
  String get bugSuccess => 'Fehler gemeldet';

  @override
  String get bugError => 'Fehler konnte nicht gesendet werden';

  @override
  String get suggestionTitle => 'Funktion vorschlagen';

  @override
  String get suggestionDescription => 'Egal ob klein, groß, verrückt, kompliziert, langweilig oder visionär – teile Deine Ideen hier mit uns.';

  @override
  String get suggestionInputHint => 'Ich wünsche mir ...';

  @override
  String get suggestionButton => 'Vorschlag senden';

  @override
  String get suggestionSuccess => 'Vorschlag gesendet';

  @override
  String get suggestionError => 'Vorschlag konnte nicht gesendet werden';
}
