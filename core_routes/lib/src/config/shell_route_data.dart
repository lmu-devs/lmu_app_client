import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../calendar.dart';
import '../../launch_flow.dart';
import '../../lectures.dart';
import '../../libraries.dart';
import '../../studies.dart';
import '../benefits/benefits.dart';
import '../cinema/cinema.dart';
import '../developerdex/developerdex.dart';
import '../explore/explore.dart';
import '../home/home.dart';
import '../mensa/mensa.dart';
import '../people/people.dart';
import '../roomfinder/roomfinder.dart';
import '../settings/settings.dart';
import '../sports/sports.dart';
import '../studies/studies.dart';
import '../timeline/timeline.dart';
import '../wishlist/wishlist.dart';
import 'scaffold_with_nav_bar.dart';

part 'shell_route_data.g.dart';

@TypedShellRoute<LaunchFlowShellRoute>(
  routes: [
    TypedGoRoute<LaunchFlowWelcomeRoute>(path: LaunchFlowWelcomeRoute.path),
    TypedGoRoute<LaunchFlowAppUpdateRoute>(path: LaunchFlowAppUpdateRoute.path),
    TypedGoRoute<LaunchFlowReleaseNotesRoute>(path: LaunchFlowReleaseNotesRoute.path),
    TypedGoRoute<LaunchFlowFacultySelectionRoute>(path: LaunchFlowFacultySelectionRoute.path),
    TypedGoRoute<LaunchFlowPermissionsOnboardingRoute>(path: LaunchFlowPermissionsOnboardingRoute.path),
  ],
)
class LaunchFlowShellRoute extends ShellRouteData {
  const LaunchFlowShellRoute();

  static const String path = '/launch';

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return navigator;
  }
}

@TypedStatefulShellRoute<MainShellRouteData>(
  branches: [
    TypedStatefulShellBranch<HomeRouteData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<HomeMainRoute>(
          path: HomeMainRoute.path,
          routes: <TypedGoRoute<GoRouteData>>[
            TypedGoRoute<SettingsMainRoute>(
              path: SettingsMainRoute.path,
              routes: <TypedGoRoute<GoRouteData>>[
                TypedGoRoute<SettingsAppearanceRoute>(
                  path: SettingsAppearanceRoute.path,
                ),
                TypedGoRoute<SettingsLanguageRoute>(
                  path: SettingsLanguageRoute.path,
                ),
                TypedGoRoute<SettingsAnalyticsRoute>(
                  path: SettingsAnalyticsRoute.path,
                ),
                TypedGoRoute<SettingsNotificationsRoute>(
                  path: SettingsNotificationsRoute.path,
                ),
                TypedGoRoute<SettingsLicenceRoute>(
                  path: SettingsLicenceRoute.path,
                ),
                TypedGoRoute<SettingsAccountRoute>(
                  path: SettingsAccountRoute.path,
                ),
                TypedGoRoute<SettingsDebugRoute>(
                  path: SettingsDebugRoute.path,
                ),
                TypedGoRoute<DeveloperdexMainRoute>(
                  path: DeveloperdexMainRoute.path,
                ),
                TypedGoRoute<FaculitesMainRoute>(
                  path: FaculitesMainRoute.path,
                ),
              ],
            ),
            TypedGoRoute<LinksRoute>(
              path: LinksRoute.path,
              routes: <TypedGoRoute<GoRouteData>>[
                TypedGoRoute<LinksSearchRoute>(
                  path: LinksSearchRoute.path,
                ),
              ],
            ),
            TypedGoRoute<BenefitsMainRoute>(
              path: BenefitsMainRoute.path,
              routes: [
                TypedGoRoute<BenefitsDetailsRoute>(
                  path: BenefitsDetailsRoute.path,
                ),
              ],
            ),
            TypedGoRoute<RoomfinderMainRoute>(
              path: RoomfinderMainRoute.path,
              routes: <TypedGoRoute<GoRouteData>>[
                TypedGoRoute<RoomfinderBuildingDetailsRoute>(
                  path: RoomfinderBuildingDetailsRoute.path,
                  routes: [
                    TypedGoRoute<RoomfinderRoomSearchRoute>(
                      path: RoomfinderRoomSearchRoute.path,
                    ),
                  ],
                ),
                TypedGoRoute<RoomfinderSearchRoute>(
                  path: RoomfinderSearchRoute.path,
                ),
              ],
            ),
            TypedGoRoute<TimelineMainRoute>(
              path: TimelineMainRoute.path,
            ),
            TypedGoRoute<SportsMainRoute>(
              path: SportsMainRoute.path,
              routes: <TypedGoRoute<GoRouteData>>[
                TypedGoRoute<SportsDetailsRoute>(
                  path: SportsDetailsRoute.path,
                ),
                TypedGoRoute<SportsSearchRoute>(
                  path: SportsSearchRoute.path,
                ),
              ],
            ),
            TypedGoRoute<CinemaMainRoute>(
              path: CinemaMainRoute.path,
              routes: <TypedGoRoute<GoRouteData>>[
                TypedGoRoute<CinemaDetailsRoute>(
                  path: CinemaDetailsRoute.path,
                ),
                TypedGoRoute<ScreeningDetailsRoute>(
                  path: ScreeningDetailsRoute.path,
                ),
                TypedGoRoute<ScreeningsHistoryRoute>(
                  path: ScreeningsHistoryRoute.path,
                ),
              ],
            ),
            TypedGoRoute<LibrariesMainRoute>(
              path: LibrariesMainRoute.path,
              routes: <TypedGoRoute<GoRouteData>>[
                TypedGoRoute<LibraryDetailsRoute>(
                  path: LibraryDetailsRoute.path,
                  routes: [
                    TypedGoRoute<LibraryAreasRoute>(
                      path: LibraryAreasRoute.path,
                    ),
                  ],
                ),
                TypedGoRoute<LibrariesSearchRoute>(
                  path: LibrariesSearchRoute.path,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<MensaData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<MensaMainRoute>(
          path: MensaMainRoute.path,
          routes: <TypedGoRoute<GoRouteData>>[
            TypedGoRoute<MensaDetailsRoute>(
              path: MensaDetailsRoute.path,
            ),
            TypedGoRoute<MensaSearchRoute>(
              path: MensaSearchRoute.path,
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<ExploreData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<ExploreMainRoute>(
          path: ExploreMainRoute.path,
          routes: [
            TypedGoRoute<ExploreSearchRoute>(
              path: ExploreSearchRoute.path,
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<WishlistData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<WishlistMainRoute>(
          path: WishlistMainRoute.path,
          routes: <TypedGoRoute<GoRouteData>>[
            TypedGoRoute<WishlistDetailsRoute>(
              path: WishlistDetailsRoute.path,
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<StudiesRouteData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<StudiesMainRoute>(
          path: StudiesMainRoute.path,
          routes: <TypedGoRoute<GoRouteData>>[
            TypedGoRoute<CalendarMainRoute>(
              path: CalendarMainRoute.path,
            ),
            TypedGoRoute<LecturesMainRoute>(
              path: LecturesMainRoute.path,
            ),
            TypedGoRoute<PeopleOverviewRoute>(
              path: PeopleOverviewRoute.path,
              routes: <TypedGoRoute<GoRouteData>>[
                TypedGoRoute<PeopleDetailsRoute>(
                  path: PeopleDetailsRoute.path,
                ),
              ],
            ),
            TypedGoRoute<PeopleFacultyOverviewRoute>(
              path: PeopleFacultyOverviewRoute.path,
            ),
          ],
        ),
      ],
    )
  ],
)
class MainShellRouteData extends StatefulShellRouteData {
  const MainShellRouteData();

  @override
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) => navigationShell;

  static const String $restorationScopeId = 'restorationScopeId';

  static Widget $navigatorContainerBuilder(
    BuildContext context,
    StatefulNavigationShell navigationShell,
    List<Widget> children,
  ) =>
      ScaffoldWithNavBar(navigationShell: navigationShell, children: children);
}
