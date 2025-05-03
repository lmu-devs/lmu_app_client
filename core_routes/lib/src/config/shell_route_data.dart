import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../libraries.dart';
import '../cinema/cinema.dart';
import '../explore/explore.dart';
import '../home/home.dart';
import '../mensa/mensa.dart';
import '../roomfinder/roomfinder.dart';
import '../settings/settings.dart';
import '../sports/sports.dart';
import '../timeline/timeline.dart';
import '../wishlist/wishlist.dart';
import 'scaffold_with_nav_bar.dart';

part 'shell_route_data.g.dart';

@TypedStatefulShellRoute<ShellRouteData>(
  branches: [
    //TODO: Add AppUpdateRoute
    TypedStatefulShellBranch<HomeRouteData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<HomeMainRoute>(
          path: HomeMainRoute.path,
          routes: <TypedGoRoute<GoRouteData>>[
            TypedGoRoute<SettingsMainRoute>(
              path: SettingsMainRoute.path,
              routes: <TypedGoRoute<GoRouteData>>[
                TypedGoRoute<SettingsApperanceRoute>(
                  path: SettingsApperanceRoute.path,
                ),
                TypedGoRoute<SettingsLanguageRoute>(
                  path: SettingsLanguageRoute.path,
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
            TypedGoRoute<BenefitsRoute>(
              path: BenefitsRoute.path,
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
                  routes: [
                    TypedGoRoute<RoomfinderSearchBuildingDetailsRoute>(
                      path: RoomfinderSearchBuildingDetailsRoute.path,
                      routes: [
                        TypedGoRoute<RoomfinderBuildingSearchRoomSearchRoute>(
                          path: RoomfinderBuildingSearchRoomSearchRoute.path,
                        ),
                      ],
                    ),
                  ],
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
                  routes: [
                    TypedGoRoute<SportsSearchDetailsRoute>(
                      path: SportsSearchDetailsRoute.path,
                    ),
                  ],
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
              routes: [
                TypedGoRoute<MensaSearchDetailsRoute>(
                  path: MensaSearchDetailsRoute.path,
                ),
              ],
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
    )
  ],
)
class ShellRouteData extends StatefulShellRouteData {
  const ShellRouteData();

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
