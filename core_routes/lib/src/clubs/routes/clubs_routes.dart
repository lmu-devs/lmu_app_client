import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../router/clubs_router.dart';

ClubsRouter get _router => GetIt.I.get<ClubsRouter>();

class ClubsMainRoute extends GoRouteData {
  const ClubsMainRoute();

  static const String path = 'clubs';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildMain(context);
}

class ClubsDetailsRoute extends GoRouteData {
  const ClubsDetailsRoute({this.categoryId});

  final String? categoryId;

  static const String path = 'clubs-details';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildDetails(context, categoryId: categoryId);
}

class ClubDetailRoute extends GoRouteData {
  const ClubDetailRoute({required this.clubId});

  final String clubId;

  static const String path = 'club-detail';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildDetail(context, clubId: clubId);
}

class ClubDetailsDetailRoute extends GoRouteData {
  const ClubDetailsDetailRoute({required this.clubId});

  final String clubId;

  static const String path = 'club-details-detail';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildDetail(context, clubId: clubId);
}
