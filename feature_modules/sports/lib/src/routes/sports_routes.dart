import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../pages/pages.dart';

part 'sports_routes.g.dart';

@TypedGoRoute<SportsMainRoute>(
  path: '/sports',
  routes: <TypedGoRoute<GoRouteData>>[],
)

class SportsMainRoute extends GoRouteData {
  const SportsMainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SportsPage();
}
