import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../localizations.dart';

extension LocalizationExtension on BuildContext {
  LmuLocalizations get locals => LmuLocalizations(this);
}

class LmuLocalizations {
  final BuildContext _context;

  const LmuLocalizations(this._context);

  AppLocalizations get app => AppLocalizations.of(_context)!;
  CanteenLocalizations get canteen => CanteenLocalizations.of(_context)!;
  ExploreLocalizations get explore => ExploreLocalizations.of(_context)!;
  WishlistLocalizations get wishlist => WishlistLocalizations.of(_context)!;
  SettingsLocalizations get settings => SettingsLocalizations.of(_context)!;
  FeedbackLocalizations get feedback => FeedbackLocalizations.of(_context)!;
  HomeLocalizations get home => HomeLocalizations.of(_context)!;
  CinemaLocalizations get cinema => CinemaLocalizations.of(_context)!;
  SportsLocatizations get sports => SportsLocatizations.of(_context)!;
  TimelineLocatizations get timeline => TimelineLocatizations.of(_context)!;
  RoomfinderLocatizations get roomfinder => RoomfinderLocatizations.of(_context)!;
  LibrariesLocatizations get libraries => LibrariesLocatizations.of(_context)!;
  BenefitsLocatizations get benefits => BenefitsLocatizations.of(_context)!;
  LaunchFlowLocatizations get launchFlow => LaunchFlowLocatizations.of(_context)!;
  StudiesLocatizations get studies => StudiesLocatizations.of(_context)!;
  PeopleLocatizations get peoples => PeopleLocatizations.of(_context)!;
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
        SportsLocatizations.delegate,
        TimelineLocatizations.delegate,
        RoomfinderLocatizations.delegate,
        LibrariesLocatizations.delegate,
        BenefitsLocatizations.delegate,
        LaunchFlowLocatizations.delegate,
        StudiesLocatizations.delegate,
        PeopleLocatizations.delegate,
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
