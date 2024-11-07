import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get openNow => 'Open now';

  @override
  String closingSoon(String time) {
    return 'Open until $time';
  }

  @override
  String get closed => 'Closed';

  @override
  String get allCanteens => 'All Canteens';

  @override
  String get favorites => 'Favorites';

  @override
  String get mensaTypeMensa => 'Mensa';

  @override
  String get mensaTypeStuBistro => 'StuBistro';

  @override
  String get mensaTypeStuCafe => 'StuCafé';

  @override
  String get mensaTypeLounge => 'Louge';

  @override
  String get alphabetically => 'Alphabetically';

  @override
  String get price => 'Price';

  @override
  String get rating => 'Rating';

  @override
  String get distance => 'Distance';

  @override
  String get type => 'Type';

  @override
  String get noFavorites => 'No favorites added yet';

  @override
  String get allClosed => 'Everything is closed';

  @override
  String get save => 'Save';

  @override
  String get myTaste => 'My Taste';

  @override
  String get myTasteDescription => 'Adjust and activate your taste profile to filter dishes by your preferences and allergies.';

  @override
  String get presets => 'Presets';

  @override
  String get reset => 'Reset';

  @override
  String get tastePreferences => 'I eat and tolerate';

  @override
  String get myTasteFooter => 'The allergens and other labelling may change due to short-term recipe and menu changes that cannot be shown on the online menu. Please be sure to check the information on the daily counter displays in the restaurant. Trace information for allergy sufferers: Traces of allergens due to cross-contamination during preparation and serving as well as due to technologically unavoidable contamination of individual ingredients cannot be ruled out and are not labelled.’ Translated with DeepL.com (free version)';
}
