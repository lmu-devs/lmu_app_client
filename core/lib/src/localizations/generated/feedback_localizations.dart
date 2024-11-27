import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'feedback_localizations_de.dart';
import 'feedback_localizations_en.dart';

/// Callers can lookup localized strings with an instance of FeedbackLocalizations
/// returned by `FeedbackLocalizations.of(context)`.
///
/// Applications need to include `FeedbackLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/feedback_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: FeedbackLocalizations.localizationsDelegates,
///   supportedLocales: FeedbackLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the FeedbackLocalizations.supportedLocales
/// property.
abstract class FeedbackLocalizations {
  FeedbackLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static FeedbackLocalizations? of(BuildContext context) {
    return Localizations.of<FeedbackLocalizations>(context, FeedbackLocalizations);
  }

  static const LocalizationsDelegate<FeedbackLocalizations> delegate = _FeedbackLocalizationsDelegate();

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

  /// The title of the Feedback Page
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedbackTitle;

  /// The description of the Feedback Page
  ///
  /// In en, this message translates to:
  /// **'How\'s your experience with the app?'**
  String get feedbackDescription;

  /// The button to send feedback
  ///
  /// In en, this message translates to:
  /// **'Send Feedback'**
  String get feedbackButton;

  /// The message shown when feedback is sent
  ///
  /// In en, this message translates to:
  /// **'Feedback sent'**
  String get feedbackSuccess;

  /// The hint text of the feedback input field
  ///
  /// In en, this message translates to:
  /// **'Tell us more sweetie ...'**
  String get feedbackInputHint;

  /// The title of the Bug Report Page
  ///
  /// In en, this message translates to:
  /// **'Report a Bug'**
  String get bugTitle;

  /// The description of the Bug Report Page
  ///
  /// In en, this message translates to:
  /// **'Have you discovered a bug? Let us know! Your feedback helps us improve the app.'**
  String get bugDescription;

  /// The hint text of the bug input field
  ///
  /// In en, this message translates to:
  /// **'I had a bug where ...'**
  String get bugInputHint;

  /// The button to report a bug
  ///
  /// In en, this message translates to:
  /// **'Report Bug'**
  String get bugButton;

  /// The message shown when a bug is reported
  ///
  /// In en, this message translates to:
  /// **'Bug reported'**
  String get bugSuccess;

  /// The title of the Suggestion Page
  ///
  /// In en, this message translates to:
  /// **'Suggest a Feature'**
  String get suggestionTitle;

  /// The description of the Suggestion Page
  ///
  /// In en, this message translates to:
  /// **'No matter whether small, big, crazy, complicated, boring or visionary – share your ideas with us here.'**
  String get suggestionDescription;

  /// The hint text of the suggestion input field
  ///
  /// In en, this message translates to:
  /// **'I wish the app had ...'**
  String get suggestionInputHint;

  /// The button to send a suggestion
  ///
  /// In en, this message translates to:
  /// **'Send Suggestion'**
  String get suggestionButton;

  /// The message shown when a suggestion is sent
  ///
  /// In en, this message translates to:
  /// **'Suggestion sent'**
  String get suggestionSuccess;
}

class _FeedbackLocalizationsDelegate extends LocalizationsDelegate<FeedbackLocalizations> {
  const _FeedbackLocalizationsDelegate();

  @override
  Future<FeedbackLocalizations> load(Locale locale) {
    return SynchronousFuture<FeedbackLocalizations>(lookupFeedbackLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_FeedbackLocalizationsDelegate old) => false;
}

FeedbackLocalizations lookupFeedbackLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return FeedbackLocalizationsDe();
    case 'en': return FeedbackLocalizationsEn();
  }

  throw FlutterError(
    'FeedbackLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
