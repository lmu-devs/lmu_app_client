import 'dart:async';

import 'package:core/core_services.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../cubit/cubit.dart';
import '../repository/api/enums/roomfinder_sort_option.dart';
import '../repository/api/models/roomfinder_street.dart';
import '../repository/roomfinder_repository.dart';
import 'roomfinder_building_view_item.dart';

class RoomfinderFilterService {
  final _roomfinderCubit = GetIt.I.get<RoomfinderCubit>();
  final _roomfinderRepository = GetIt.I.get<RoomfinderRepository>();
  final _locationService = GetIt.I.get<LocationService>();

  final ValueNotifier<RoomfinderSortOption> _sortOptionNotifier = ValueNotifier(RoomfinderSortOption.alphabetically);
  ValueNotifier<RoomfinderSortOption> get sortOptionNotifier => _sortOptionNotifier;

  final List<RoomfinderStreet> _streets = [];
  final ValueNotifier<List<List<RoomfinderBuildingViewItem>>> _filteredBuildingsNotifier = ValueNotifier([]);
  ValueNotifier<List<List<RoomfinderBuildingViewItem>>> get filteredBuildingsNotifier => _filteredBuildingsNotifier;
  List<List<RoomfinderBuildingViewItem>> _mappedBuildingViewItems = [];

  StreamSubscription? _cubitSubscription;

  void init() {
    _cubitSubscription = _roomfinderCubit.stream.withInitialValue(_roomfinderCubit.state).listen((state) {
      if (state is RoomfinderLoadSuccess) {
        _streets
          ..clear()
          ..addAll(state.streets);

        _updateFilteredBuildings();
      }
    });

    _roomfinderRepository.getSortOption().then((sortOption) {
      if (sortOption != null) {
        _sortOptionNotifier.value = sortOption;
        _updateFilteredBuildings();
      }
    });

    _locationService.addListener(_updateFilteredBuildings);
  }

  void _updateFilteredBuildings() {
    _mappedBuildingViewItems = _streets.map((street) {
      return street.buildings.map((building) {
        final location = building.location;
        final distance = _locationService.getDistance(lat: location.latitude, long: location.longitude);
        return RoomfinderBuildingViewItem(
          id: building.buildingPartId,
          title: building.title,
          distance: distance,
        );
      }).toList();
    }).toList();

    _sortBuildings();
    _filteredBuildingsNotifier.value = List.of(_mappedBuildingViewItems);
  }

  void _sortBuildings() {
    switch (_sortOptionNotifier.value) {
      case RoomfinderSortOption.alphabetically:
        _mappedBuildingViewItems.sort((a, b) => a.first.title.compareTo(b.first.title));
        break;
      case RoomfinderSortOption.distance:
        final allbuildings = _mappedBuildingViewItems.expand((element) => element).toList();
        allbuildings.sort((a, b) => (a.distance ?? double.infinity).compareTo(b.distance ?? double.infinity));
        _mappedBuildingViewItems = allbuildings.map((e) => [e]).toList();
        break;
    }
  }

  Future<void> updateSortOption(RoomfinderSortOption sortOption) async {
    _sortOptionNotifier.value = sortOption;
    _updateFilteredBuildings();
    await _roomfinderRepository.saveSortOption(sortOption);
  }

  void dispose() {
    _cubitSubscription?.cancel();
    _locationService.removeListener(_updateFilteredBuildings);
    _sortOptionNotifier.dispose();
    _filteredBuildingsNotifier.dispose();
  }

  Future<bool> hasLocationPermission() async {
    final isLocationPermissionGranted = await PermissionsService.isLocationPermissionGranted();
    if (!isLocationPermissionGranted) return false;

    final isLocationServicesEnabled = await PermissionsService.isLocationServicesEnabled();
    if (!isLocationServicesEnabled) return false;

    await GetIt.I.get<LocationService>().updatePosition();
    return true;
  }
}
