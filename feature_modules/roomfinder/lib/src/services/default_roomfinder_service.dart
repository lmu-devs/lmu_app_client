import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_api/roomfinder.dart';

import '../routes/roomfinder_routes.dart';

class DefaultRoomfinderService extends RoomfinderService {
  @override
  RouteBase get roomfinderData => $roomfinderMainRoute;

  @override
  void navigateToRoomfinder(BuildContext context) {
    const RoomfinderMainRoute().go(context);
  }
}
