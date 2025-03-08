import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_api/explore.dart';
import 'package:shared_api/roomfinder.dart';

import '../cubit/roomfinder_cubit/roomfinder_cubit.dart';
import '../routes/roomfinder_routes.dart';

class DefaultRoomfinderService extends RoomfinderService {
  @override
  RouteBase get roomfinderData => $roomfinderMainRoute;

  @override
  void navigateToRoomfinder(BuildContext context) {
    const RoomfinderMainRoute().go(context);
  }

  @override
  Stream<List<ExploreLocation>> get roomfinderExploreLocationsStream {
    return GetIt.I.get<RoomfinderCubit>().roomfinderExploreLocationsStream;
  }
}
