import 'canteen_localizations.dart';

/// The translations for German (`de`).
class CanteenLocalizationsDe extends CanteenLocalizations {
  CanteenLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get tabTitle => 'Mensa';

  @override
  String get openNow => 'Jetzt geöffnet';

  @override
  String openUntil(String time) {
    return 'Geöffnet bis $time Uhr';
  }

  @override
  String openingSoon(String time) {
    return 'Öffnet um $time Uhr';
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
  String get reset => 'Reset';

  @override
  String get tastePreferences => 'Ich esse und vertrage';

  @override
  String get myTasteFooter => 'Die Allergene und die übrigen Kennzeichnungen ändern sich möglicherweise durch kurzfristige Rezeptur- und Speiseplanänderungen, die nicht im Internetspeiseplan ersichtlich sein können. Bitte beachten Sie unbedingt die Angaben auf den tagesaktuellen Thekenaufstellern in der Betriebsstelle. Spurenhinweis für Allergiker: Spuren von Allergenen durch Kreuzkontaminationen während der Vor- und Zubereitung bzw. Ausgabe sowie durch technologisch unvermeidbare Verunreinigungen einzelner Zutaten können nicht ausgeschlossen werden und werden nicht gekennzeichnet.';

  @override
  String get noConnection => 'Keine Verbindung';

  @override
  String get retry => 'Neu laden';

  @override
  String get share => 'Teilen';

  @override
  String openDetails(String openingTime, String closingTime) {
    return 'Geöffnet von $openingTime-$closingTime Uhr';
  }

  @override
  String get closedDetailed => 'Gerade geschlossen';

  @override
  String get emptyFavoritesBefore => 'Füge Favoriten mit dem ';

  @override
  String get emptyFavoritesAfter => ' Symbol hinzu';
}
