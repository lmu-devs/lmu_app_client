import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'wishlist_localizations_de.dart';
import 'wishlist_localizations_en.dart';

/// Callers can lookup localized strings with an instance of WishlistLocalizations
/// returned by `WishlistLocalizations.of(context)`.
///
/// Applications need to include `WishlistLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/wishlist_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: WishlistLocalizations.localizationsDelegates,
///   supportedLocales: WishlistLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the WishlistLocalizations.supportedLocales
/// property.
abstract class WishlistLocalizations {
  WishlistLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static WishlistLocalizations? of(BuildContext context) {
    return Localizations.of<WishlistLocalizations>(context, WishlistLocalizations);
  }

  static const LocalizationsDelegate<WishlistLocalizations> delegate = _WishlistLocalizationsDelegate();

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

  /// The title of the Wishlist Page
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get tabTitle;

  /// Intro text for the wishlist page
  ///
  /// In en, this message translates to:
  /// **'The app is still on its way of reaching its full potential. Good things take time and thoughtful decisions. Help us figure out which features you miss the most.'**
  String get wishlistIntro;

  /// Share app
  ///
  /// In en, this message translates to:
  /// **'Share App'**
  String get shareApp;

  /// Rate app
  ///
  /// In en, this message translates to:
  /// **'Rate App'**
  String get rateApp;

  /// Rate app error toast
  ///
  /// In en, this message translates to:
  /// **'Opening store failed'**
  String get rateAppError;

  /// No description provided for @instagram.
  ///
  /// In en, this message translates to:
  /// **'Instagram'**
  String get instagram;

  /// Beta title
  ///
  /// In en, this message translates to:
  /// **'Become a beta tester'**
  String get betaTitle;

  /// Beta subtitle
  ///
  /// In en, this message translates to:
  /// **'Test new app functions early'**
  String get betaSubtitle;

  /// Title of the wishlist-entries section
  ///
  /// In en, this message translates to:
  /// **'Future Features'**
  String get wishlistEntriesTitle;

  /// Hidden
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get wishlistStatusHidden;

  /// In development
  ///
  /// In en, this message translates to:
  /// **'In Development'**
  String get wishlistStatusDevelopment;

  /// Beta
  ///
  /// In en, this message translates to:
  /// **'Beta'**
  String get wishlistStatusBeta;

  /// Done
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get wishlistStatusDone;

  /// Like error
  ///
  /// In en, this message translates to:
  /// **'Your like couldn\'t be saved'**
  String get likeError;

  /// Test prototype button
  ///
  /// In en, this message translates to:
  /// **'Test Prototype'**
  String get testPrototype;

  /// Prototype error toast
  ///
  /// In en, this message translates to:
  /// **'Launching prototype failed'**
  String get prototypeError;

  /// Text that is between the index of the current preview image and the amount of all preview images e.g [1 of 4].
  ///
  /// In en, this message translates to:
  /// **'of'**
  String get previewImageCount;
}

class _WishlistLocalizationsDelegate extends LocalizationsDelegate<WishlistLocalizations> {
  const _WishlistLocalizationsDelegate();

  @override
  Future<WishlistLocalizations> load(Locale locale) {
    return SynchronousFuture<WishlistLocalizations>(lookupWishlistLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_WishlistLocalizationsDelegate old) => false;
}

WishlistLocalizations lookupWishlistLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return WishlistLocalizationsDe();
    case 'en':
      return WishlistLocalizationsEn();
  }

  throw FlutterError('WishlistLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
