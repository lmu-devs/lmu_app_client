import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../pages/cinema_details_page.dart';
import '../pages/pages.dart';
import 'cinema_details_data.dart';

part 'cinema_routes.g.dart';

@TypedGoRoute<CinemaMainRoute>(
  path: '/cinema',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<CinemaDetailsRoute>(
      path: 'details',
    ),
  ],
)
class CinemaMainRoute extends GoRouteData {
  const CinemaMainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const CinemaPage();
}

class CinemaDetailsRoute extends GoRouteData {
  const CinemaDetailsRoute(
    this.$extra,
  );

  final CinemaDetailsData $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => CinemaDetailsPage(
        cinemaDetailsData: $extra,
      );
}
