import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../models/router_sports_type.dart';
import '../router/sports_router.dart';

SportsRouter get _router => GetIt.I.get<SportsRouter>();

class SportsMainRoute extends GoRouteData {
  const SportsMainRoute();

  static const String path = 'sports';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildMain(context);
}

class SportsDetailsRoute extends GoRouteData {
  const SportsDetailsRoute(this.$extra);

  final RSportsType $extra;

  static const String path = 'details';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildDetails(context, $extra);
}

class SportsSearchRoute extends GoRouteData {
  const SportsSearchRoute();

  static const String path = 'search';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildSearch(context);
}

class SportsSearchDetailsRoute extends GoRouteData {
  const SportsSearchDetailsRoute(this.$extra);

  final RSportsType $extra;

  static const String path = 'details';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildDetails(context, $extra);
}
