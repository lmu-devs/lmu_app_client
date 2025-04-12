import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_api/explore.dart';
import 'package:shared_api/roomfinder.dart';

import '../cubit/cubit.dart';
import '../pages/roomfinder_building_details_page.dart';
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
    final roomfinderCubit = GetIt.I.get<RoomfinderCubit>();
    final state = roomfinderCubit.state;
    if (state is! RoomfinderLoadSuccess && state is! RoomfinderLoadInProgress) {
      roomfinderCubit.loadRoomfinderLocations();
    }

    return roomfinderCubit.roomfinderExploreLocationsStream;
  }

  @override
  Widget getRoomfinderPage(String buildingId) {
    final roomfinderCubit = GetIt.I.get<RoomfinderCubit>();
    final state = roomfinderCubit.state;
    if (state is! RoomfinderLoadSuccess) {
      return const SizedBox.shrink();
    } else {
      return RoomfinderBuildingDetailsPage(buildingId: buildingId);
    }
  }
}
