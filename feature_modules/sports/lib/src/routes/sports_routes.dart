import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../pages/pages.dart';
import '../repository/repository.dart';

part 'sports_routes.g.dart';

@TypedGoRoute<SportsMainRoute>(
  path: '/sports',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<SportsDetailsRoute>(
      path: 'details',
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

  final SportsModel $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => SportsDetailsPage(sport: $extra);
}
