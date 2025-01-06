import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'explore_localizations_de.dart';
import 'explore_localizations_en.dart';

/// Callers can lookup localized strings with an instance of ExploreLocalizations
/// returned by `ExploreLocalizations.of(context)`.
///
/// Applications need to include `ExploreLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/explore_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ExploreLocalizations.localizationsDelegates,
///   supportedLocales: ExploreLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the ExploreLocalizations.supportedLocales
/// property.
abstract class ExploreLocalizations {
  ExploreLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ExploreLocalizations? of(BuildContext context) {
    return Localizations.of<ExploreLocalizations>(context, ExploreLocalizations);
  }

  static const LocalizationsDelegate<ExploreLocalizations> delegate = _ExploreLocalizationsDelegate();

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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en')
  ];

  /// Navigation option with Google Maps
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get tabTitle;

  /// No description provided for @navigate.
  ///
  /// In en, this message translates to:
  /// **'Navigate'**
  String get navigate;

  /// No description provided for @openWith.
  ///
  /// In en, this message translates to:
  /// **'Open with'**
  String get openWith;

  /// No description provided for @appleMaps.
  ///
  /// In en, this message translates to:
  /// **'Apple Maps'**
  String get appleMaps;

  /// No description provided for @googleMaps.
  ///
  /// In en, this message translates to:
  /// **'Google Maps'**
  String get googleMaps;

  /// Copy address to clipboard
  ///
  /// In en, this message translates to:
  /// **'Copy Address'**
  String get copyToClipboard;

  /// Toast message for copied address
  ///
  /// In en, this message translates to:
  /// **'Address copied to clipboard'**
  String get copiedToClipboard;
}

class _ExploreLocalizationsDelegate extends LocalizationsDelegate<ExploreLocalizations> {
  const _ExploreLocalizationsDelegate();

  @override
  Future<ExploreLocalizations> load(Locale locale) {
    return SynchronousFuture<ExploreLocalizations>(lookupExploreLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_ExploreLocalizationsDelegate old) => false;
}

ExploreLocalizations lookupExploreLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return ExploreLocalizationsDe();
    case 'en': return ExploreLocalizationsEn();
  }

  throw FlutterError(
    'ExploreLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
