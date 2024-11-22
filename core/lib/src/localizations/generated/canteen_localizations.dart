import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'canteen_localizations_de.dart';
import 'canteen_localizations_en.dart';

/// Callers can lookup localized strings with an instance of CanteenLocalizations
/// returned by `CanteenLocalizations.of(context)`.
///
/// Applications need to include `CanteenLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/canteen_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: CanteenLocalizations.localizationsDelegates,
///   supportedLocales: CanteenLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the CanteenLocalizations.supportedLocales
/// property.
abstract class CanteenLocalizations {
  CanteenLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static CanteenLocalizations? of(BuildContext context) {
    return Localizations.of<CanteenLocalizations>(context, CanteenLocalizations);
  }

  static const LocalizationsDelegate<CanteenLocalizations> delegate = _CanteenLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('de'), Locale('en')];

  /// The title of the meals tab
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get tabTitle;

  /// The state of being open
  ///
  /// In en, this message translates to:
  /// **'Open now'**
  String get openNow;

  /// The state of closing soon
  ///
  /// In en, this message translates to:
  /// **'Open until {time}'**
  String openUntil(String time);

  /// The state of opening soon
  ///
  /// In en, this message translates to:
  /// **'Open from {time}'**
  String openingSoon(String time);

  /// The state of being closed
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// Display all canteens
  ///
  /// In en, this message translates to:
  /// **'All Canteens'**
  String get allCanteens;

  /// Favrourite canteens
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// The type of a canteen
  ///
  /// In en, this message translates to:
  /// **'Mensa'**
  String get mensaTypeMensa;

  /// The type of a canteen
  ///
  /// In en, this message translates to:
  /// **'StuBistro'**
  String get mensaTypeStuBistro;

  /// The type of a canteen
  ///
  /// In en, this message translates to:
  /// **'StuCafé'**
  String get mensaTypeStuCafe;

  /// The type of a canteen
  ///
  /// In en, this message translates to:
  /// **'Louge'**
  String get mensaTypeLounge;

  /// Alphabetically sorting
  ///
  /// In en, this message translates to:
  /// **'Alphabetically'**
  String get alphabetically;

  /// Price sorting
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// Rating sorting
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// Distance sorting
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// Type
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No favorites added yet
  ///
  /// In en, this message translates to:
  /// **'No favorites added yet'**
  String get noFavorites;

  /// All canteens are closed
  ///
  /// In en, this message translates to:
  /// **'Everything is closed'**
  String get allClosed;

  /// The action of saving
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// The user's taste
  ///
  /// In en, this message translates to:
  /// **'My Taste'**
  String get myTaste;

  /// The user's taste description
  ///
  /// In en, this message translates to:
  /// **'Adjust and activate your taste profile to filter dishes by your preferences and allergies.'**
  String get myTasteDescription;

  /// Presets
  ///
  /// In en, this message translates to:
  /// **'Presets'**
  String get presets;

  /// Reset
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// The user's taste preferences
  ///
  /// In en, this message translates to:
  /// **'I eat and tolerate'**
  String get tastePreferences;

  /// The user's taste footer
  ///
  /// In en, this message translates to:
  /// **'The allergens and other labelling may change due to short-term recipe and menu changes that cannot be shown on the online menu. Please be sure to check the information on the daily counter displays in the restaurant. Trace information for allergy sufferers: Traces of allergens due to cross-contamination during preparation and serving as well as due to technologically unavoidable contamination of individual ingredients cannot be ruled out and are not labelled.’ Translated with DeepL.com (free version)'**
  String get myTasteFooter;

  /// No connection
  ///
  /// In en, this message translates to:
  /// **'No connection'**
  String get noConnection;

  /// Retry
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Share button
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// The state of closing soon
  ///
  /// In en, this message translates to:
  /// **'Open from {openingTime}-{closingTime}'**
  String openDetails(String openingTime, String closingTime);

  /// The state of being closed
  ///
  /// In en, this message translates to:
  /// **'Currently closed'**
  String get closedDetailed;

  /// Empty favorites text before star icon
  ///
  /// In en, this message translates to:
  /// **'Tap the '**
  String get emptyFavoritesBefore;

  /// Empty favorites text after star icon
  ///
  /// In en, this message translates to:
  /// **' icon to add favorites here'**
  String get emptyFavoritesAfter;

  /// Students
  ///
  /// In en, this message translates to:
  /// **'Students'**
  String get students;

  /// Staff
  ///
  /// In en, this message translates to:
  /// **'Staff'**
  String get staff;

  /// Guests
  ///
  /// In en, this message translates to:
  /// **'Guests'**
  String get guests;
}

class _CanteenLocalizationsDelegate extends LocalizationsDelegate<CanteenLocalizations> {
  const _CanteenLocalizationsDelegate();

  @override
  Future<CanteenLocalizations> load(Locale locale) {
    return SynchronousFuture<CanteenLocalizations>(lookupCanteenLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_CanteenLocalizationsDelegate old) => false;
}

CanteenLocalizations lookupCanteenLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return CanteenLocalizationsDe();
    case 'en':
      return CanteenLocalizationsEn();
  }

  throw FlutterError('CanteenLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
