import 'explore_localizations.dart';

/// The translations for English (`en`).
class ExploreLocalizationsEn extends ExploreLocalizations {
  ExploreLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get tabTitle => 'Explore';

  @override
  String get navigate => 'Navigate';

  @override
  String get openWith => 'Open with';

  @override
  String get appleMaps => 'Apple Maps';

  @override
  String get googleMaps => 'Google Maps';

  @override
  String get copyToClipboard => 'Copy Address';

  @override
  String get copiedToClipboard => 'Address copied to clipboard';
}
