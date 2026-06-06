import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../localizations.dart';

extension LocalizationExtension on BuildContext {
  LmuLocalizations get locals => LmuLocalizations(this);
}

class LmuLocalizations {
  const LmuLocalizations(this._context);
  final BuildContext _context;

  AppLocalizations get app => AppLocalizations.of(_context)!;
  CanteenLocalizations get canteen => CanteenLocalizations.of(_context)!;
  ExploreLocalizations get explore => ExploreLocalizations.of(_context)!;
  WishlistLocalizations get wishlist => WishlistLocalizations.of(_context)!;
  SettingsLocalizations get settings => SettingsLocalizations.of(_context)!;
  FeedbackLocalizations get feedback => FeedbackLocalizations.of(_context)!;
  HomeLocalizations get home => HomeLocalizations.of(_context)!;
  CinemaLocalizations get cinema => CinemaLocalizations.of(_context)!;
  SportsLocalizations get sports => SportsLocalizations.of(_context)!;
  TimelineLocalizations get timeline => TimelineLocalizations.of(_context)!;
  RoomfinderLocalizations get roomfinder => RoomfinderLocalizations.of(_context)!;
  LibrariesLocalizations get libraries => LibrariesLocalizations.of(_context)!;
  BenefitsLocalizations get benefits => BenefitsLocalizations.of(_context)!;
  LaunchFlowLocalizations get launchFlow => LaunchFlowLocalizations.of(_context)!;
  StudiesLocalizations get studies => StudiesLocalizations.of(_context)!;
  CoursesLocalizations get courses => CoursesLocalizations.of(_context)!;
  PeopleLocalizations get people => PeopleLocalizations.of(_context)!;
  DeveloperdexLocalizations get developerdex => DeveloperdexLocalizations.of(_context)!;
  GradesLocalizations get grades => GradesLocalizations.of(_context)!;
  ClubsLocalizations get clubs => ClubsLocalizations.of(_context)!;
  // Add other localizations

  /// List of all supported localizations delegates
  static List<LocalizationsDelegate> get localizationsDelegates => [
        AppLocalizations.delegate,
        CanteenLocalizations.delegate,
        ExploreLocalizations.delegate,
        WishlistLocalizations.delegate,
        SettingsLocalizations.delegate,
        FeedbackLocalizations.delegate,
        HomeLocalizations.delegate,
        CinemaLocalizations.delegate,
        SportsLocalizations.delegate,
        TimelineLocalizations.delegate,
        RoomfinderLocalizations.delegate,
        LibrariesLocalizations.delegate,
        BenefitsLocalizations.delegate,
        LaunchFlowLocalizations.delegate,
        StudiesLocalizations.delegate,
        CoursesLocalizations.delegate,
        PeopleLocalizations.delegate,
        DeveloperdexLocalizations.delegate,
        GradesLocalizations.delegate,
        ClubsLocalizations.delegate,
        // Add other localizations delegates

        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];

  /// List of all supported locales
  static List<Locale> get supportedLocales => const [
        Locale('en'),
        Locale('de'),
        // Add other supported locales
      ];
}
