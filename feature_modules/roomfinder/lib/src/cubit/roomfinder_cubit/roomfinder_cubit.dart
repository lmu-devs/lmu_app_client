import 'package:core/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/explore.dart';

import '../../repository/roomfinder_repository.dart';
import 'roomfinder_state.dart';

class RoomfinderCubit extends Cubit<RoomfinderState> {
  RoomfinderCubit() : super(const RoomfinderInitial());

  final _repository = GetIt.I.get<RoomfinderRepository>();

  Future<void> loadRoomfinderLocations() async {
    emit(const RoomfinderLoadInProgress());

    try {
      final streets = await _repository.getRoomfinderData();
      emit(RoomfinderLoadSuccess(streets: streets));
    } catch (e) {
      if (e is NoNetworkException) {
        emit(const RoomfinderLoadFailure(loadState: LoadState.noNetworkError));
      } else {
        emit(const RoomfinderLoadFailure(loadState: LoadState.genericError));
      }
    }
  }

  Stream<List<ExploreLocation>> get roomfinderExploreLocationsStream {
    return stream.withInitialValue(state).map(
      (state) {
        if (state is RoomfinderLoadSuccess) {
          final streets = state.streets;
          final buildings = streets.expand((street) => street.buildings).toList();

          return buildings.map((building) {
            final buildingLocation = building.location;
            return ExploreLocation(
              id: building.buildingPartId,
              latitude: buildingLocation.latitude,
              longitude: buildingLocation.longitude,
              name: building.title,
              address: buildingLocation.address,
              type: ExploreMarkerType.roomfinderBuilding,
            );
          }).toList();
        } else {
          return <ExploreLocation>[];
        }
      },
    );
  }
}
