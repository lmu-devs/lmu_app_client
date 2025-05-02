import 'package:flutter/material.dart';

import '../../../explore.dart';

abstract class RoomfinderService {
  Stream<List<ExploreLocation>> get roomfinderExploreLocationsStream;

  void navigateToRoomfinder(BuildContext context);

  List<Widget> roomfinderMapContentBuilder(BuildContext context, String buildingId, ScrollController controller);
}
