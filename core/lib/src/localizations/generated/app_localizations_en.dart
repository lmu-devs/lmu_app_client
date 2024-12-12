import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'LMU Students';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get undo => 'Undo';

  @override
  String get reset => 'Reset';

  @override
  String get favoriteAdded => 'Favorite added';

  @override
  String get favoriteRemoved => 'Favorite removed';

  @override
  String get iconStar => 'Star';

  @override
  String get today => 'Today';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String get search => 'Search';

  @override
  String get locationServiceDialogTitle => 'Location Services Disabled';

  @override
  String get locationServiceDialogText =>
      'To access all features of the app, please enable location services. This will allow us to provide you with more personalized and accurate information.';

  @override
  String get ok => 'OK';

  @override
  String get locationPermissionDialogTitle => 'Permission Required';

  @override
  String get locationPermissionDialogText =>
      'This feature needs location access. Open settings to grant the permission.';

  @override
  String get cancel => 'Cancel';

  @override
  String get settings => 'Settings';

  @override
  String get suggestFeature => 'Suggest a feature';

  @override
  String get reportBug => 'Report a bug';
}
