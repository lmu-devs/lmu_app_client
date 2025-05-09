import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../router/roomfinder_router.dart';

RoomfinderRouter get _router => GetIt.I.get<RoomfinderRouter>();

class RoomfinderMainRoute extends GoRouteData {
  const RoomfinderMainRoute();

  static const String path = 'roomfinder';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildMain(context);
}

class RoomfinderBuildingDetailsRoute extends GoRouteData {
  const RoomfinderBuildingDetailsRoute(this.buildingId);

  final String buildingId;

  static const String path = 'details';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildDetails(context, buildingId);
}

class RoomfinderSearchRoute extends GoRouteData {
  const RoomfinderSearchRoute();

  static const String path = 'search';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildSearch(context);
}

class RoomfinderRoomSearchRoute extends GoRouteData {
  const RoomfinderRoomSearchRoute(this.buildingId);

  final String buildingId;

  static const String path = 'search_room';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildRoomSearch(context);
}

class RoomfinderBuildingSearchRoomSearchRoute extends GoRouteData {
  const RoomfinderBuildingSearchRoomSearchRoute(this.buildingId);

  final String buildingId;

  static const String path = 'search';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildRoomSearch(context);
}
