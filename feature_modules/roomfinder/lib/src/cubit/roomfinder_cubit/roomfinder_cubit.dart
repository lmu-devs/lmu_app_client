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
      final cities = await _repository.getRoomfinderCities();
      emit(RoomfinderLoadSuccess(cities: cities));
    } catch (e) {
      emit(const RoomfinderLoadFailure());
    }
  }

  Stream<List<ExploreLocation>> get roomfinderExploreLocationsStream {
    return stream.withInitialValue(state).map(
      (state) {
        if (state is RoomfinderLoadSuccess) {
          final cities = state.cities;
          final streets = cities.expand((city) => city.streets).toList();
          final buildings = streets.expand((street) => street.buildings).toList();

          return buildings.map((building) {
            final buildingLocation = building.location;
            return ExploreLocation(
              id: building.id,
              latitude: buildingLocation.latitude,
              longitude: buildingLocation.longitude,
              name: building.title,
              type: ExploreMarkerType.roomfinderRoom,
            );
          }).toList();
        } else {
          return <ExploreLocation>[];
        }
      },
    );
  }
}
