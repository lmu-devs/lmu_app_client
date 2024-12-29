import 'canteen_localizations.dart';

/// The translations for English (`en`).
class CanteenLocalizationsEn extends CanteenLocalizations {
  CanteenLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get tabTitle => 'Food';

  @override
  String get openNow => 'Open now';

  @override
  String openUntil(String time) {
    return 'Open until $time';
  }

  @override
  String openingSoon(String time) {
    return 'Open from $time';
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
  String get mensaTypeLounge => 'StuLouge';

  @override
  String get mensaTypeEspressoBar => 'Espresso';

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
  String get myTasteDescription =>
      'Adjust and activate your taste profile to filter dishes by your preferences and allergies.';

  @override
  String get presets => 'Presets';

  @override
  String get reset => 'Reset';

  @override
  String get tastePreferences => 'I eat and tolerate';

  @override
  String get myTasteFooter =>
      'The allergens and other labelling may change due to short-term recipe and menu changes that cannot be shown on the online menu. Please be sure to check the information on the daily counter displays in the restaurant. Trace information for allergy sufferers: Traces of allergens due to cross-contamination during preparation and serving as well as due to technologically unavoidable contamination of individual ingredients cannot be ruled out and are not labelled.';

  @override
  String get noConnection => 'No connection';

  @override
  String get retry => 'Retry';

  @override
  String get share => 'Share';

  @override
  String openDetails(String openingTime, String closingTime) {
    return 'Open from $openingTime-$closingTime';
  }

  @override
  String get closedDetailed => 'Currently closed';

  @override
  String get emptyFavoritesBefore => 'Tap the ';

  @override
  String get emptyFavoritesAfter => ' icon to add favorites here';

  @override
  String get students => 'Students';

  @override
  String get staff => 'Staff';

  @override
  String get guests => 'Guests';

  @override
  String get mainDish => 'Main Dish';

  @override
  String get soupDish => 'Soups / Studitopf';

  @override
  String get sideDish => 'Sides';

  @override
  String get dessertDish => 'Desserts';

  @override
  String get canteenInfo => '300+ seats, daily changing main meals, including vegetarian and vegan options.';

  @override
  String get bistroInfo => '100-300 seats, specialized in snacks and smaller dishes.';

  @override
  String get cafeInfo => 'under 100 seats, focused on beverages and small snacks.';

  @override
  String get notYourTaste => 'Not your taste';

  @override
  String get tasteProfilePlaceholderNotActive =>
      'Activate your taste profile to filter dishes by preferences and allergies.';

  @override
  String get tasteProfilePlaceholderActive =>
      'Adjust your taste profile to filter dishes by preferences and allergies.';

  @override
  String get temporaryClosed => 'Temporarily closed';

  @override
  String servingOpenDetails(String openingTime, String closingTime) {
    return 'Serving open from $openingTime-$closingTime';
  }

  @override
  String servingOpenUntil(String time) {
    return 'Serving open until $time';
  }

  @override
  String servingOpeningSoon(String time) {
    return 'Serving open from $time';
  }

  @override
  String get servingClosed => 'Serving closed';
}
