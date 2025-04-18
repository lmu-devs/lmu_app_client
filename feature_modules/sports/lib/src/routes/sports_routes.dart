import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../pages/pages.dart';
import '../pages/sports_search_page.dart';
import '../repository/repository.dart';

part 'sports_routes.g.dart';

@TypedGoRoute<SportsMainRoute>(
  path: '/sports',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<SportsDetailsRoute>(
      path: 'details',
    ),
    TypedGoRoute<SportsInfoRoute>(
      path: 'info',
    ),
    TypedGoRoute<SportsTicketRoute>(
      path: 'tickets',
    ),
    TypedGoRoute<SportsSearchRoute>(
      path: 'search',
      routes: [
        TypedGoRoute<SportsSearchDetailsRoute>(
          path: 'searchDetails',
        ),
      ],
    ),
  ],
)
class SportsMainRoute extends GoRouteData {
  const SportsMainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SportsPage();
}

class SportsDetailsRoute extends GoRouteData {
  const SportsDetailsRoute(this.$extra);

  final SportsType $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => SportsDetailsPage(sport: $extra);
}

class SportsInfoRoute extends GoRouteData {
  const SportsInfoRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SportsInfoPage();
}

class SportsTicketRoute extends GoRouteData {
  const SportsTicketRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SportsTicketsPage();
}

class SportsSearchRoute extends GoRouteData {
  const SportsSearchRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SportsSearchPage();
}

class SportsSearchDetailsRoute extends GoRouteData {
  const SportsSearchDetailsRoute(this.$extra);

  final SportsType $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => SportsDetailsPage(sport: $extra);
}
