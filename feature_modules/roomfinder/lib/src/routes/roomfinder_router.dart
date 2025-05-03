import 'package:core_routes/roomfinder.dart';
import 'package:flutter/material.dart';

import '../pages/pages.dart';

class RoomfinderRouterImpl extends RoomfinderRouter {
  @override
  Widget buildMain(BuildContext context) => const RoomfinderPage();

  @override
  Widget buildDetails(BuildContext context, String id) => RoomfinderBuildingDetailsPage(buildingId: id);

  @override
  Widget buildRoomSearch(BuildContext contex) => const RoomfinderRoomSearchPage();

  @override
  Widget buildSearch(BuildContext context) => const RoomfinderSearchPage();
}
