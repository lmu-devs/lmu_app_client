import 'wishlist_localizations.dart';

/// The translations for English (`en`).
class WishlistLocalizationsEn extends WishlistLocalizations {
  WishlistLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get tabTitle => 'Wishlist';

  @override
  String get wishlistIntro =>
      'The app is still on its way of reaching its full potential. Good things take time and thoughtful decisions. Help us figure out which features you miss the most.';

  @override
  String get shareApp => 'Share App';

  @override
  String get rateApp => 'Rate App';

  @override
  String get rateAppError => 'Opening store failed';

  @override
  String get instagram => 'Instagram';

  @override
  String get betaTitle => 'Become a beta tester';

  @override
  String get betaSubtitle => 'Test new app functions early';

  @override
  String get wishlistEntriesTitle => 'Future Features';

  @override
  String get wishlistStatusHidden => 'Hidden';

  @override
  String get wishlistStatusDevelopment => 'In Development';

  @override
  String get wishlistStatusBeta => 'Beta';

  @override
  String get wishlistStatusDone => 'Done';

  @override
  String get testPrototype => 'Test Prototype';

  @override
  String get prototypeError => 'Launching prototype failed';

  @override
  String get previewImageCount => 'of';
}
