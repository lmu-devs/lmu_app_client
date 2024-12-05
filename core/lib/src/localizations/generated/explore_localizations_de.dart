import 'explore_localizations.dart';

/// The translations for German (`de`).
class ExploreLocalizationsDe extends ExploreLocalizations {
  ExploreLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get tabTitle => 'Entdecken';

  @override
  String get navigate => 'Navigieren';

  @override
  String get openWith => 'Öffnen mit';

  @override
  String get appleMaps => 'Apple Karten';

  @override
  String get googleMaps => 'Google Maps';

  @override
  String get copyToClipboard => 'Oder Adresse kopieren';

  @override
  String get copiedToClipboard => 'Adresse kopiert';
}
