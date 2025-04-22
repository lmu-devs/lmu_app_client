import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../explore.dart';

abstract class RoomfinderService {
  RouteBase get roomfinderData;

  Stream<List<ExploreLocation>> get roomfinderExploreLocationsStream;

  void navigateToRoomfinder(BuildContext context);

  List<Widget> roomfinderMapContentBuilder(BuildContext context, String buildingId, ScrollController controller);
}
