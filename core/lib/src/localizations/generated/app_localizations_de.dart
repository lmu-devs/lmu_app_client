import 'app_localizations.dart';

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get helloWorld => 'Hallo Welt!';

  @override
  String get openNow => 'Jetzt geöffnet';

  @override
  String closingSoon(String time) {
    return 'Geöffnet bis $time Uhr';
  }

  @override
  String get closed => 'Geschlossen';

  @override
  String get allCanteens => 'Alle Mensen';

  @override
  String get favorites => 'Favoriten';

  @override
  String get mensaTypeMensa => 'Mensa';

  @override
  String get mensaTypeStuBistro => 'StuBistro';

  @override
  String get mensaTypeStuCafe => 'StuCafé';

  @override
  String get mensaTypeLounge => 'Louge';

  @override
  String get alphabetically => 'Alphabetisch';

  @override
  String get price => 'Preis';

  @override
  String get rating => 'Bewertung';

  @override
  String get distance => 'Entfernung';

  @override
  String get type => 'Typ';

  @override
  String get noFavorites => 'Noch keine Favoriten hinzugefügt';

  @override
  String get allClosed => 'Everything is closed';
}
