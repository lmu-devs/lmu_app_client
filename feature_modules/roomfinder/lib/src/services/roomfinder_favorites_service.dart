import 'dart:async';

import 'package:core/core_services.dart';
import 'package:core/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../cubit/cubit.dart';
import '../repository/api/models/roomfinder_building.dart';
import '../repository/roomfinder_repository.dart';
import 'roomfinder_building_view_item.dart';

class RoomfinderFavoritesService {
  final _roomfinderCubit = GetIt.I.get<RoomfinderCubit>();
  final _roomfinderRepo = GetIt.I.get<RoomfinderRepository>();
  final _locationService = GetIt.I.get<LocationService>();

  final ValueNotifier<List<RoomfinderBuildingViewItem>> _favoriteBuildingsNotifier = ValueNotifier([]);

  ValueNotifier<List<RoomfinderBuildingViewItem>> get favoriteBuildingsNotifier => _favoriteBuildingsNotifier;

  List<RoomfinderBuilding> _buildings = [];
  StreamSubscription? _cubitSubscription;

  void init() {
    _cubitSubscription = _roomfinderCubit.stream.withInitialValue(_roomfinderCubit.state).listen((state) {
      if (state is RoomfinderLoadSuccess) {
        _roomfinderRepo.getFavoriteBuildings().then(
          (favoriteBuildingIds) {
            _buildings = state.cities.expand((city) => city.streets).expand((street) => street.buildings).toList();

            final favoriteBuildings =
                _buildings.where((building) => favoriteBuildingIds.contains(building.id)).toList();

            _favoriteBuildingsNotifier.value = favoriteBuildings.map((building) {
              final location = building.location;
              final distance = _locationService.getDistance(lat: location.latitude, long: location.longitude);
              return RoomfinderBuildingViewItem(
                id: building.id,
                title: building.title,
                distance: distance,
              );
            }).toList();
          },
        );
      }
    });

    _locationService.addListener(_onLocationChanged);
  }

  void _onLocationChanged() {
    final favoriteBuildings =
        _buildings.where((building) => _favoriteBuildingsNotifier.value.any((b) => b.id == building.id)).toList();
    _favoriteBuildingsNotifier.value = favoriteBuildings.map((building) {
      final location = building.location;
      final distance = _locationService.getDistance(lat: location.latitude, long: location.longitude);
      return RoomfinderBuildingViewItem(
        id: building.id,
        title: building.title,
        distance: distance,
      );
    }).toList();
  }

  Future<void> toggleFavorite(String buildingId) async {
    final currentFavorites = List.of(_favoriteBuildingsNotifier.value);
    final isAlreadyFavorite = currentFavorites.any((building) => building.id == buildingId);

    if (isAlreadyFavorite) {
      currentFavorites.removeWhere((building) => building.id == buildingId);
    } else {
      final building = _buildings.firstWhere((building) => building.id == buildingId);
      currentFavorites.add(
        RoomfinderBuildingViewItem(
          id: building.id,
          title: building.title,
          distance: _locationService.getDistance(
            lat: building.location.latitude,
            long: building.location.longitude,
          ),
        ),
      );
    }

    _favoriteBuildingsNotifier.value = currentFavorites;
    await _roomfinderRepo.saveFavoriteBuildings(currentFavorites.map((b) => b.id).toList());
  }

  void dispose() {
    _cubitSubscription?.cancel();
    _locationService.removeListener(_onLocationChanged);
    _favoriteBuildingsNotifier.dispose();
  }
}
