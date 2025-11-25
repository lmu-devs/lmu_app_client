// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shell_route_data.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $launchFlowShellRoute,
      $mainShellRouteData,
    ];

RouteBase get $launchFlowShellRoute => ShellRouteData.$route(
      factory: $LaunchFlowShellRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/welcome',
          factory: $LaunchFlowWelcomeRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/app_update',
          factory: $LaunchFlowAppUpdateRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/release_notes',
          factory: $LaunchFlowReleaseNotesRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/faculty_selection',
          factory: $LaunchFlowFacultySelectionRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/permissions_onboarding',
          factory: $LaunchFlowPermissionsOnboardingRouteExtension._fromState,
        ),
      ],
    );

extension $LaunchFlowShellRouteExtension on LaunchFlowShellRoute {
  static LaunchFlowShellRoute _fromState(GoRouterState state) => const LaunchFlowShellRoute();
}

extension $LaunchFlowWelcomeRouteExtension on LaunchFlowWelcomeRoute {
  static LaunchFlowWelcomeRoute _fromState(GoRouterState state) => const LaunchFlowWelcomeRoute();

  String get location => GoRouteData.$location(
        '/welcome',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LaunchFlowAppUpdateRouteExtension on LaunchFlowAppUpdateRoute {
  static LaunchFlowAppUpdateRoute _fromState(GoRouterState state) => const LaunchFlowAppUpdateRoute();

  String get location => GoRouteData.$location(
        '/app_update',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LaunchFlowReleaseNotesRouteExtension on LaunchFlowReleaseNotesRoute {
  static LaunchFlowReleaseNotesRoute _fromState(GoRouterState state) => const LaunchFlowReleaseNotesRoute();

  String get location => GoRouteData.$location(
        '/release_notes',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LaunchFlowFacultySelectionRouteExtension on LaunchFlowFacultySelectionRoute {
  static LaunchFlowFacultySelectionRoute _fromState(GoRouterState state) => const LaunchFlowFacultySelectionRoute();

  String get location => GoRouteData.$location(
        '/faculty_selection',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LaunchFlowPermissionsOnboardingRouteExtension on LaunchFlowPermissionsOnboardingRoute {
  static LaunchFlowPermissionsOnboardingRoute _fromState(GoRouterState state) =>
      const LaunchFlowPermissionsOnboardingRoute();

  String get location => GoRouteData.$location(
        '/permissions_onboarding',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mainShellRouteData => StatefulShellRouteData.$route(
      restorationScopeId: MainShellRouteData.$restorationScopeId,
      navigatorContainerBuilder: MainShellRouteData.$navigatorContainerBuilder,
      factory: $MainShellRouteDataExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/home',
              factory: $HomeMainRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'settings',
                  factory: $SettingsMainRouteExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'appearance',
                      factory: $SettingsAppearanceRouteExtension._fromState,
                    ),
                    GoRouteData.$route(
                      path: 'language',
                      factory: $SettingsLanguageRouteExtension._fromState,
                    ),
                    GoRouteData.$route(
                      path: 'notifications',
                      factory: $SettingsNotificationsRouteExtension._fromState,
                    ),
                    GoRouteData.$route(
                      path: 'license',
                      factory: $SettingsLicenceRouteExtension._fromState,
                    ),
                    GoRouteData.$route(
                      path: 'account',
                      factory: $SettingsAccountRouteExtension._fromState,
                      routes: [
                        GoRouteData.$route(
                          path: 'analytics',
                          factory: $SettingsAnalyticsRouteExtension._fromState,
                        ),
                      ],
                    ),
                    GoRouteData.$route(
                      path: 'debug',
                      factory: $SettingsDebugRouteExtension._fromState,
                    ),
                    GoRouteData.$route(
                      path: 'developerdex',
                      factory: $DeveloperdexMainRouteExtension._fromState,
                    ),
                    GoRouteData.$route(
                      path: 'faculites',
                      factory: $FaculitesMainRouteExtension._fromState,
                    ),
                  ],
                ),
                GoRouteData.$route(
                  path: 'links',
                  factory: $LinksRouteExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'links_faculties',
                      factory: $LinksFacultiesRouteExtension._fromState,
                    ),
                    GoRouteData.$route(
                      path: 'links_overview',
                      factory: $LinksOverviewRouteExtension._fromState,
                    ),
                    GoRouteData.$route(
                      path: 'search',
                      factory: $LinksSearchRouteExtension._fromState,
                    ),
                  ],
                ),
                GoRouteData.$route(
                  path: 'benefits',
                  factory: $BenefitsMainRouteExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'details',
                      factory: $BenefitsDetailsRouteExtension._fromState,
                    ),
                  ],
                ),
                GoRouteData.$route(
                  path: 'roomfinder',
                  factory: $RoomfinderMainRouteExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'details',
                      factory: $RoomfinderBuildingDetailsRouteExtension._fromState,
                      routes: [
                        GoRouteData.$route(
                          path: 'search_room',
                          factory: $RoomfinderRoomSearchRouteExtension._fromState,
                        ),
                      ],
                    ),
                    GoRouteData.$route(
                      path: 'search',
                      factory: $RoomfinderSearchRouteExtension._fromState,
                    ),
                  ],
                ),
                GoRouteData.$route(
                  path: 'timeline',
                  factory: $TimelineMainRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'sports',
                  factory: $SportsMainRouteExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'details',
                      factory: $SportsDetailsRouteExtension._fromState,
                    ),
                    GoRouteData.$route(
                      path: 'search',
                      factory: $SportsSearchRouteExtension._fromState,
                    ),
                  ],
                ),
                GoRouteData.$route(
                  path: 'cinema',
                  factory: $CinemaMainRouteExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'details',
                      factory: $CinemaDetailsRouteExtension._fromState,
                    ),
                    GoRouteData.$route(
                      path: 'screening',
                      factory: $ScreeningDetailsRouteExtension._fromState,
                    ),
                    GoRouteData.$route(
                      path: 'screenings_history',
                      factory: $ScreeningsHistoryRouteExtension._fromState,
                    ),
                  ],
                ),
                GoRouteData.$route(
                  path: 'libraries',
                  factory: $LibrariesMainRouteExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'details',
                      factory: $LibraryDetailsRouteExtension._fromState,
                      routes: [
                        GoRouteData.$route(
                          path: 'areas',
                          factory: $LibraryAreasRouteExtension._fromState,
                        ),
                      ],
                    ),
                    GoRouteData.$route(
                      path: 'search',
                      factory: $LibrariesSearchRouteExtension._fromState,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/mensa',
              factory: $MensaMainRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'details',
                  factory: $MensaDetailsRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'search',
                  factory: $MensaSearchRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/explore',
              factory: $ExploreMainRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'search',
                  factory: $ExploreSearchRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/wishlist',
              factory: $WishlistMainRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'details',
                  factory: $WishlistDetailsRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/studies',
              factory: $StudiesMainRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'calendar',
                  factory: $CalendarMainRouteExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'calendar/test',
                      factory: $CalendarTestRouteExtension._fromState,
                    ),
                    GoRouteData.$route(
                      path: 'search',
                      factory: $CalendarSearchRouteExtension._fromState,
                    ),
                    GoRouteData.$route(
                      path: 'create',
                      factory: $CalendarCreateRouteExtension._fromState,
                    ),
                  ],
                ),
                GoRouteData.$route(
                  path: 'lectures',
                  factory: $LecturesMainRouteExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'lecture-list',
                      factory: $LectureListRouteExtension._fromState,
                    ),
                  ],
                ),
                GoRouteData.$route(
                  path: 'people',
                  factory: $PeopleOverviewRouteExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'details',
                      factory: $PeopleDetailsRouteExtension._fromState,
                    ),
                    GoRouteData.$route(
                      path: 'people-search',
                      factory: $PeopleSearchRouteExtension._fromState,
                    ),
                  ],
                ),
                GoRouteData.$route(
                  path: 'people-faculties',
                  factory: $PeopleFacultyOverviewRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'grades',
                  factory: $GradesMainRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
      ],
    );

extension $MainShellRouteDataExtension on MainShellRouteData {
  static MainShellRouteData _fromState(GoRouterState state) => const MainShellRouteData();
}

extension $HomeMainRouteExtension on HomeMainRoute {
  static HomeMainRoute _fromState(GoRouterState state) => const HomeMainRoute();

  String get location => GoRouteData.$location(
        '/home',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsMainRouteExtension on SettingsMainRoute {
  static SettingsMainRoute _fromState(GoRouterState state) => const SettingsMainRoute();

  String get location => GoRouteData.$location(
        '/home/settings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsAppearanceRouteExtension on SettingsAppearanceRoute {
  static SettingsAppearanceRoute _fromState(GoRouterState state) => const SettingsAppearanceRoute();

  String get location => GoRouteData.$location(
        '/home/settings/appearance',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsLanguageRouteExtension on SettingsLanguageRoute {
  static SettingsLanguageRoute _fromState(GoRouterState state) => const SettingsLanguageRoute();

  String get location => GoRouteData.$location(
        '/home/settings/language',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsNotificationsRouteExtension on SettingsNotificationsRoute {
  static SettingsNotificationsRoute _fromState(GoRouterState state) => const SettingsNotificationsRoute();

  String get location => GoRouteData.$location(
        '/home/settings/notifications',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsLicenceRouteExtension on SettingsLicenceRoute {
  static SettingsLicenceRoute _fromState(GoRouterState state) => const SettingsLicenceRoute();

  String get location => GoRouteData.$location(
        '/home/settings/license',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsAccountRouteExtension on SettingsAccountRoute {
  static SettingsAccountRoute _fromState(GoRouterState state) => const SettingsAccountRoute();

  String get location => GoRouteData.$location(
        '/home/settings/account',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsAnalyticsRouteExtension on SettingsAnalyticsRoute {
  static SettingsAnalyticsRoute _fromState(GoRouterState state) => const SettingsAnalyticsRoute();

  String get location => GoRouteData.$location(
        '/home/settings/account/analytics',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsDebugRouteExtension on SettingsDebugRoute {
  static SettingsDebugRoute _fromState(GoRouterState state) => const SettingsDebugRoute();

  String get location => GoRouteData.$location(
        '/home/settings/debug',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DeveloperdexMainRouteExtension on DeveloperdexMainRoute {
  static DeveloperdexMainRoute _fromState(GoRouterState state) => const DeveloperdexMainRoute();

  String get location => GoRouteData.$location(
        '/home/settings/developerdex',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $FaculitesMainRouteExtension on FaculitesMainRoute {
  static FaculitesMainRoute _fromState(GoRouterState state) => const FaculitesMainRoute();

  String get location => GoRouteData.$location(
        '/home/settings/faculites',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LinksRouteExtension on LinksRoute {
  static LinksRoute _fromState(GoRouterState state) => const LinksRoute();

  String get location => GoRouteData.$location(
        '/home/links',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LinksFacultiesRouteExtension on LinksFacultiesRoute {
  static LinksFacultiesRoute _fromState(GoRouterState state) => const LinksFacultiesRoute();

  String get location => GoRouteData.$location(
        '/home/links/links_faculties',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LinksOverviewRouteExtension on LinksOverviewRoute {
  static LinksOverviewRoute _fromState(GoRouterState state) => LinksOverviewRoute(
        facultyId: int.parse(state.uri.queryParameters['faculty-id']!)!,
      );

  String get location => GoRouteData.$location(
        '/home/links/links_overview',
        queryParams: {
          'faculty-id': facultyId.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LinksSearchRouteExtension on LinksSearchRoute {
  static LinksSearchRoute _fromState(GoRouterState state) => LinksSearchRoute(
        facultyId: int.parse(state.uri.queryParameters['faculty-id']!)!,
      );

  String get location => GoRouteData.$location(
        '/home/links/search',
        queryParams: {
          'faculty-id': facultyId.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $BenefitsMainRouteExtension on BenefitsMainRoute {
  static BenefitsMainRoute _fromState(GoRouterState state) => const BenefitsMainRoute();

  String get location => GoRouteData.$location(
        '/home/benefits',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $BenefitsDetailsRouteExtension on BenefitsDetailsRoute {
  static BenefitsDetailsRoute _fromState(GoRouterState state) => BenefitsDetailsRoute(
        state.extra as RBenefitCategory?,
      );

  String get location => GoRouteData.$location(
        '/home/benefits/details',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}

extension $RoomfinderMainRouteExtension on RoomfinderMainRoute {
  static RoomfinderMainRoute _fromState(GoRouterState state) => const RoomfinderMainRoute();

  String get location => GoRouteData.$location(
        '/home/roomfinder',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $RoomfinderBuildingDetailsRouteExtension on RoomfinderBuildingDetailsRoute {
  static RoomfinderBuildingDetailsRoute _fromState(GoRouterState state) => RoomfinderBuildingDetailsRoute(
        state.uri.queryParameters['building-id']!,
      );

  String get location => GoRouteData.$location(
        '/home/roomfinder/details',
        queryParams: {
          'building-id': buildingId,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $RoomfinderRoomSearchRouteExtension on RoomfinderRoomSearchRoute {
  static RoomfinderRoomSearchRoute _fromState(GoRouterState state) => RoomfinderRoomSearchRoute(
        state.uri.queryParameters['building-id']!,
      );

  String get location => GoRouteData.$location(
        '/home/roomfinder/details/search_room',
        queryParams: {
          'building-id': buildingId,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $RoomfinderSearchRouteExtension on RoomfinderSearchRoute {
  static RoomfinderSearchRoute _fromState(GoRouterState state) => const RoomfinderSearchRoute();

  String get location => GoRouteData.$location(
        '/home/roomfinder/search',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $TimelineMainRouteExtension on TimelineMainRoute {
  static TimelineMainRoute _fromState(GoRouterState state) => const TimelineMainRoute();

  String get location => GoRouteData.$location(
        '/home/timeline',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SportsMainRouteExtension on SportsMainRoute {
  static SportsMainRoute _fromState(GoRouterState state) => const SportsMainRoute();

  String get location => GoRouteData.$location(
        '/home/sports',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SportsDetailsRouteExtension on SportsDetailsRoute {
  static SportsDetailsRoute _fromState(GoRouterState state) => SportsDetailsRoute(
        state.extra as RSportsType,
      );

  String get location => GoRouteData.$location(
        '/home/sports/details',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}

extension $SportsSearchRouteExtension on SportsSearchRoute {
  static SportsSearchRoute _fromState(GoRouterState state) => const SportsSearchRoute();

  String get location => GoRouteData.$location(
        '/home/sports/search',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CinemaMainRouteExtension on CinemaMainRoute {
  static CinemaMainRoute _fromState(GoRouterState state) => const CinemaMainRoute();

  String get location => GoRouteData.$location(
        '/home/cinema',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CinemaDetailsRouteExtension on CinemaDetailsRoute {
  static CinemaDetailsRoute _fromState(GoRouterState state) => CinemaDetailsRoute(
        state.extra as RCinemaDetailsData,
      );

  String get location => GoRouteData.$location(
        '/home/cinema/details',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}

extension $ScreeningDetailsRouteExtension on ScreeningDetailsRoute {
  static ScreeningDetailsRoute _fromState(GoRouterState state) => ScreeningDetailsRoute(
        state.extra as RScreeningDetailsData,
      );

  String get location => GoRouteData.$location(
        '/home/cinema/screening',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}

extension $ScreeningsHistoryRouteExtension on ScreeningsHistoryRoute {
  static ScreeningsHistoryRoute _fromState(GoRouterState state) => ScreeningsHistoryRoute(
        state.extra as RScreeningsHistoryData,
      );

  String get location => GoRouteData.$location(
        '/home/cinema/screenings_history',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}

extension $LibrariesMainRouteExtension on LibrariesMainRoute {
  static LibrariesMainRoute _fromState(GoRouterState state) => const LibrariesMainRoute();

  String get location => GoRouteData.$location(
        '/home/libraries',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LibraryDetailsRouteExtension on LibraryDetailsRoute {
  static LibraryDetailsRoute _fromState(GoRouterState state) => LibraryDetailsRoute(
        state.extra as RLibraryModel,
      );

  String get location => GoRouteData.$location(
        '/home/libraries/details',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}

extension $LibraryAreasRouteExtension on LibraryAreasRoute {
  static LibraryAreasRoute _fromState(GoRouterState state) => LibraryAreasRoute(
        state.extra as RLibraryModel,
      );

  String get location => GoRouteData.$location(
        '/home/libraries/details/areas',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}

extension $LibrariesSearchRouteExtension on LibrariesSearchRoute {
  static LibrariesSearchRoute _fromState(GoRouterState state) => const LibrariesSearchRoute();

  String get location => GoRouteData.$location(
        '/home/libraries/search',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MensaMainRouteExtension on MensaMainRoute {
  static MensaMainRoute _fromState(GoRouterState state) => const MensaMainRoute();

  String get location => GoRouteData.$location(
        '/mensa',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MensaDetailsRouteExtension on MensaDetailsRoute {
  static MensaDetailsRoute _fromState(GoRouterState state) => MensaDetailsRoute(
        state.extra as RMensaModel,
      );

  String get location => GoRouteData.$location(
        '/mensa/details',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}

extension $MensaSearchRouteExtension on MensaSearchRoute {
  static MensaSearchRoute _fromState(GoRouterState state) => const MensaSearchRoute();

  String get location => GoRouteData.$location(
        '/mensa/search',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ExploreMainRouteExtension on ExploreMainRoute {
  static ExploreMainRoute _fromState(GoRouterState state) => const ExploreMainRoute();

  String get location => GoRouteData.$location(
        '/explore',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ExploreSearchRouteExtension on ExploreSearchRoute {
  static ExploreSearchRoute _fromState(GoRouterState state) => const ExploreSearchRoute();

  String get location => GoRouteData.$location(
        '/explore/search',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $WishlistMainRouteExtension on WishlistMainRoute {
  static WishlistMainRoute _fromState(GoRouterState state) => const WishlistMainRoute();

  String get location => GoRouteData.$location(
        '/wishlist',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $WishlistDetailsRouteExtension on WishlistDetailsRoute {
  static WishlistDetailsRoute _fromState(GoRouterState state) => WishlistDetailsRoute(
        state.extra as RWishlistModel,
      );

  String get location => GoRouteData.$location(
        '/wishlist/details',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}

extension $StudiesMainRouteExtension on StudiesMainRoute {
  static StudiesMainRoute _fromState(GoRouterState state) => const StudiesMainRoute();

  String get location => GoRouteData.$location(
        '/studies',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CalendarMainRouteExtension on CalendarMainRoute {
  static CalendarMainRoute _fromState(GoRouterState state) => const CalendarMainRoute();

  String get location => GoRouteData.$location(
        '/studies/calendar',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CalendarTestRouteExtension on CalendarTestRoute {
  static CalendarTestRoute _fromState(GoRouterState state) => const CalendarTestRoute();

  String get location => GoRouteData.$location(
        '/studies/calendar/calendar/test',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CalendarSearchRouteExtension on CalendarSearchRoute {
  static CalendarSearchRoute _fromState(GoRouterState state) => const CalendarSearchRoute();

  String get location => GoRouteData.$location(
        '/studies/calendar/search',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CalendarCreateRouteExtension on CalendarCreateRoute {
  static CalendarCreateRoute _fromState(GoRouterState state) => const CalendarCreateRoute();

  String get location => GoRouteData.$location(
        '/studies/calendar/create',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LecturesMainRouteExtension on LecturesMainRoute {
  static LecturesMainRoute _fromState(GoRouterState state) => const LecturesMainRoute();

  String get location => GoRouteData.$location(
        '/studies/lectures',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LectureListRouteExtension on LectureListRoute {
  static LectureListRoute _fromState(GoRouterState state) => LectureListRoute(
        state.extra as Map<String, dynamic>,
      );

  String get location => GoRouteData.$location(
        '/studies/lectures/lecture-list',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}

extension $PeopleOverviewRouteExtension on PeopleOverviewRoute {
  static PeopleOverviewRoute _fromState(GoRouterState state) => PeopleOverviewRoute(
        facultyId: int.parse(state.uri.queryParameters['faculty-id']!)!,
      );

  String get location => GoRouteData.$location(
        '/studies/people',
        queryParams: {
          'faculty-id': facultyId.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PeopleDetailsRouteExtension on PeopleDetailsRoute {
  static PeopleDetailsRoute _fromState(GoRouterState state) => PeopleDetailsRoute(
        facultyId: int.parse(state.uri.queryParameters['faculty-id']!)!,
        personId: int.parse(state.uri.queryParameters['person-id']!)!,
      );

  String get location => GoRouteData.$location(
        '/studies/people/details',
        queryParams: {
          'faculty-id': facultyId.toString(),
          'person-id': personId.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PeopleSearchRouteExtension on PeopleSearchRoute {
  static PeopleSearchRoute _fromState(GoRouterState state) => PeopleSearchRoute(
        facultyId: int.parse(state.uri.queryParameters['faculty-id']!)!,
      );

  String get location => GoRouteData.$location(
        '/studies/people/people-search',
        queryParams: {
          'faculty-id': facultyId.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PeopleFacultyOverviewRouteExtension on PeopleFacultyOverviewRoute {
  static PeopleFacultyOverviewRoute _fromState(GoRouterState state) => const PeopleFacultyOverviewRoute();

  String get location => GoRouteData.$location(
        '/studies/people-faculties',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $GradesMainRouteExtension on GradesMainRoute {
  static GradesMainRoute _fromState(GoRouterState state) => const GradesMainRoute();

  String get location => GoRouteData.$location(
        '/studies/grades',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
