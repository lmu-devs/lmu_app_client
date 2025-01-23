import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../pages/pages.dart';

part 'cinema_routes.g.dart';

@TypedGoRoute<CinemaMainRoute>(
  path: '/cinema',
  routes: <TypedGoRoute<GoRouteData>>[],
)

class CinemaMainRoute extends GoRouteData {
  const CinemaMainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const CinemaPage();
}
