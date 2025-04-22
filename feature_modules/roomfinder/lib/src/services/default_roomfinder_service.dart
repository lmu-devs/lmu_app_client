import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_api/explore.dart';
import 'package:shared_api/roomfinder.dart';

import '../cubit/cubit.dart';
import '../routes/roomfinder_routes.dart';
import '../widgets/widgets.dart';

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
  List<Widget> roomfinderMapContentBuilder(BuildContext context, String buildingId, ScrollController controller) {
    final roomfinderCubit = GetIt.I<RoomfinderCubit>();
    final state = roomfinderCubit.state;
    if (state is! RoomfinderLoadSuccess) return [];

    final building = state.streets
        .expand((street) => street.buildings)
        .firstWhere((building) => building.buildingPartId == buildingId);
    final floors = building.floors;

    return [
      RoomfinderBuildingDetailsSection(
        key: Key('roomfinderMapDetails$buildingId'),
        building: building,
      ),
      RoomfinderBuildingButtonSection(
        key: Key('roomfinderMapButton$buildingId'),
        building: building,
        withMapButton: false,
      ),
      RoomfinderBuildingFloorsSection(
        key: Key('roomfinderMapFloors$buildingId'),
        floors: floors,
        building: building,
      ),
    ];
  }
}
