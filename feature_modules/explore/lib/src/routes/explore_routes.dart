import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_api/cinema.dart';
import 'package:shared_api/mensa.dart';
import 'package:shared_api/roomfinder.dart';

import '../pages/explore_page.dart';
import '../pages/explore_search_page.dart';

part 'explore_routes.g.dart';

@TypedStatefulShellBranch<ExploreData>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<ExploreMainRoute>(
      path: '/explore',
      routes: [
        TypedGoRoute<ExploreSearchRoute>(
          path: 'search',
        ),
        TypedGoRoute<ExploreMensaRoute>(
          path: 'mensa',
        ),
        TypedGoRoute<ExploreBuildingRoute>(
          path: 'building',
        ),
        TypedGoRoute<ExploreCinemaRoute>(
          path: 'cinema',
        ),
      ],
    ),
  ],
)
class ExploreData extends StatefulShellBranchData {
  const ExploreData();
}

class ExploreMainRoute extends GoRouteData {
  const ExploreMainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const ExplorePage();
}

class ExploreSearchRoute extends GoRouteData {
  const ExploreSearchRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const ExploreSearchPage();
}

class ExploreMensaRoute extends GoRouteData {
  const ExploreMensaRoute(this.mensaId);

  final String mensaId;

  @override
  Widget build(BuildContext context, GoRouterState state) => GetIt.I.get<MensaService>().getMensaPage(mensaId);
}

class ExploreBuildingRoute extends GoRouteData {
  const ExploreBuildingRoute(this.buildingId);

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      GetIt.I.get<RoomfinderService>().getRoomfinderPage(buildingId);
}

class ExploreCinemaRoute extends GoRouteData {
  const ExploreCinemaRoute(this.cinemaId);

  final String cinemaId;

  @override
  Widget build(BuildContext context, GoRouterState state) => GetIt.I.get<CinemaService>().getCinemaPage(cinemaId);
}
