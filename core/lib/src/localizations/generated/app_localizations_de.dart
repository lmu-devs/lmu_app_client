import 'app_localizations.dart';

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'LMU Students';

  @override
  String get monday => 'Montag';

  @override
  String get tuesday => 'Dienstag';

  @override
  String get wednesday => 'Mittwoch';

  @override
  String get thursday => 'Donnerstag';

  @override
  String get friday => 'Freitag';

  @override
  String get undo => 'Rückgängig';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get favoriteAdded => 'Favorit hinzugefügt';

  @override
  String get favoriteRemoved => 'Favorit entfernt';

  @override
  String get iconStar => 'Stern';

  @override
  String get today => 'Heute';

  @override
  String get tomorrow => 'Morgen';

  @override
  String get search => 'Suchen';

  @override
  String get locationServiceDialogTitle => 'Standortdienste deaktiviert';

  @override
  String get locationServiceDialogText => 'Um alle Funktionen der App nutzen zu können, aktiviere bitte deine Standortdienste. So können wir dir personalisierte und genauere Informationen bieten.';

  @override
  String get ok => 'OK';

  @override
  String get locationPermissionDialogTitle => 'Fehlende Berechtigung';

  @override
  String get locationPermissionDialogText => 'Diese Funktion benötigt deinen Standort. Öffne Einstellungen, um diese Berechtigung zu erteilen.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get settings => 'Einstellungen';
}
