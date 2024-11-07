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
  String get allClosed => 'Alles geschlossen';

  @override
  String get save => 'Speichern';

  @override
  String get myTaste => 'My Taste';

  @override
  String get myTasteDescription => 'Passen Sie Ihr Geschmacksprofil an und aktivieren Sie es, um Gerichte nach Ihren Vorlieben und Allergien zu filtern.';

  @override
  String get presets => 'Vorlagen';

  @override
  String get reset => 'Diskrimieren';

  @override
  String get tastePreferences => 'Ich esse und vertrage';

  @override
  String get myTasteFooter => 'Die Allergene und die übrigen Kennzeichnungen ändern sich möglicherweise durch kurzfristige Rezeptur- und Speiseplanänderungen, die nicht im Internetspeiseplan ersichtlich sein können. Bitte beachten Sie unbedingt die Angaben auf den tagesaktuellen Thekenaufstellern in der Betriebsstelle. Spurenhinweis für Allergiker: Spuren von Allergenen durch Kreuzkontaminationen während der Vor- und Zubereitung bzw. Ausgabe sowie durch technologisch unvermeidbare Verunreinigungen einzelner Zutaten können nicht ausgeschlossen werden und werden nicht gekennzeichnet.';
}
