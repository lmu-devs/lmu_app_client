import 'package:flutter/material.dart';

import '../../../explore.dart';

abstract class RoomfinderService {
  Stream<List<ExploreLocation>> get roomfinderExploreLocationsStream;

  List<Widget> roomfinderMapContentBuilder(BuildContext context, String buildingId, ScrollController controller);
}
