import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../models/router_cinema_details_data.dart';
import '../models/router_screening_details_data.dart';
import '../models/router_screenings_history_data.dart';
import '../router/cinema_router.dart';

CinemaRouter get _router => GetIt.I.get<CinemaRouter>();

class CinemaMainRoute extends GoRouteData {
  const CinemaMainRoute();

  static const String path = 'cinema';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildMain(context);
}

class CinemaDetailsRoute extends GoRouteData {
  const CinemaDetailsRoute(this.$extra);

  final RCinemaDetailsData $extra;

  static const String path = 'details';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildDetails(context, $extra);
}

class ScreeningDetailsRoute extends GoRouteData {
  const ScreeningDetailsRoute(this.$extra);

  final RScreeningDetailsData $extra;

  static const String path = 'screening';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildScreeningDetails(context, $extra);
}

class ScreeningsHistoryRoute extends GoRouteData {
  const ScreeningsHistoryRoute(this.$extra);

  final RScreeningsHistoryData $extra;

  static const String path = 'screenings_history';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildScreeningHistory(context, $extra);
}
