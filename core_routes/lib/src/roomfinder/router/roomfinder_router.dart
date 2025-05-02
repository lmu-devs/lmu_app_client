import 'package:flutter/material.dart';

abstract class RoomfinderRouter {
  Widget buildMain(BuildContext context);

  Widget buildDetails(BuildContext context, String id);

  Widget buildSearch(BuildContext context);

  Widget buildRoomSearch(BuildContext context);
}
