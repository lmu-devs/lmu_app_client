import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../pages/cinema_details_page.dart';
import '../pages/pages.dart';
import '../pages/screening_details_page.dart';
import '../pages/screenings_history_page.dart';
import '../repository/api/api.dart';
import 'cinema_details_data.dart';

part 'cinema_routes.g.dart';

@TypedGoRoute<CinemaMainRoute>(
  path: '/cinema',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<CinemaDetailsRoute>(
      path: 'cinema_details',
    ),
    TypedGoRoute<ScreeningDetailsRoute>(
      path: 'screening_details',
    ),
    TypedGoRoute<ScreeningsHistoryRoute>(
      path: 'screenings_history',
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

class ScreeningDetailsRoute extends GoRouteData {
  const ScreeningDetailsRoute(
      this.$extra,
      );

  final ScreeningModel $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => ScreeningDetailsPage(
    screening: $extra,
  );
}


class ScreeningsHistoryRoute extends GoRouteData {
  const ScreeningsHistoryRoute(
      this.$extra,
      );

  final List<ScreeningModel> $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => ScreeningsHistoryPage(
    screenings: $extra,
  );
}
