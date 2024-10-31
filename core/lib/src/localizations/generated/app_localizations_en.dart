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
}
