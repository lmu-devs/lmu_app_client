import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../pages/pages.dart';
import '../pages/roomfinder_building_details_page.dart';
import '../pages/roomfinder_room_details_page.dart';
import '../pages/roomfinder_room_search_page.dart';
import '../repository/api/models/roomfinder_room.dart';

part 'roomfinder_routes.g.dart';

@TypedGoRoute<RoomfinderMainRoute>(
  path: '/roomfinder',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<RoomfinderBuildingDetailsRoute>(
      path: 'buildingDetails',
      routes: [
        TypedGoRoute<RoomfinderBuildingRoomDetailsRoute>(
          path: 'buildingRoomDetails',
        ),
        TypedGoRoute<RoomfinderRoomSearchRoute>(
          path: 'roomSearch',
        ),
      ],
    ),
    TypedGoRoute<RoomfinderRoomDetailsRoute>(
      path: 'roomDetails',
    ),
    TypedGoRoute<RoomfinderSearchRoute>(
      path: 'search',
      routes: [
        TypedGoRoute<RoomfinderSearchBuildingRoute>(
          path: 'buildingDetails',
          routes: [
            TypedGoRoute<RoomfinderRoomSearchRoute>(
              path: 'roomSearch',
            ),
          ],
        ),
      ],
    ),
  ],
)
class RoomfinderMainRoute extends GoRouteData {
  const RoomfinderMainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const RoomfinderPage();
}

class RoomfinderBuildingDetailsRoute extends GoRouteData {
  const RoomfinderBuildingDetailsRoute(this.buildingId);

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) => RoomfinderBuildingDetailsPage(buildingId: buildingId);
}

class RoomfinderRoomDetailsRoute extends GoRouteData {
  const RoomfinderRoomDetailsRoute(this.$extra);

  final RoomfinderRoom $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => RoomfinderRoomDetailsPage(room: $extra, buildingId: "");
}

class RoomfinderBuildingRoomDetailsRoute extends GoRouteData {
  const RoomfinderBuildingRoomDetailsRoute(this.$extra);

  final RoomfinderRoom $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => RoomfinderRoomDetailsPage(room: $extra, buildingId: "");
}

class RoomfinderSearchRoute extends GoRouteData {
  const RoomfinderSearchRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const RoomfinderSearchPage();
}

class RoomfinderSearchBuildingRoute extends GoRouteData {
  const RoomfinderSearchBuildingRoute(this.buildingId);

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) => RoomfinderBuildingDetailsPage(buildingId: buildingId);
}

class RoomfinderRoomSearchRoute extends GoRouteData {
  const RoomfinderRoomSearchRoute(this.buildingId);

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) => const RoomfinderRoomSearchPage();
}
