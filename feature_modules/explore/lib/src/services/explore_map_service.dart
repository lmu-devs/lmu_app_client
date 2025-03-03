import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_api/cinema.dart';
import 'package:shared_api/explore.dart';
import 'package:shared_api/mensa.dart';

import '../cubit/cubit.dart';

class ExploreMapService {
  void init() {
    _mapController = MapController();

    _loadExploreLocations();
  }

  MapController get mapController => _mapController;
  ValueNotifier<String?> get selectedMarkerNotifier => _selectedMarkerNotifier;
  ValueNotifier<List<ExploreLocation>> get exploreLocationsNotifier => _exploreLocationsNotifier;
  ValueNotifier<ExploreMarkerSize> get exploreMarkerSizeNotifier => _exploreMarkerSizeNotifier;

  final ValueNotifier<String?> _selectedMarkerNotifier = ValueNotifier(null);

  final ValueNotifier<List<ExploreLocation>> _exploreLocationsNotifier = ValueNotifier([]);
  final ValueNotifier<ExploreMarkerSize> _exploreMarkerSizeNotifier = ValueNotifier(ExploreMarkerSize.medium);
  late final MapController _mapController;

  void _loadExploreLocations() {
    final mensaService = GetIt.I<MensaService>();
    mensaService.mensaExploreLocationsStream.listen((locations) {
      final currentLocations = List.of(_exploreLocationsNotifier.value);
      final updatedLocations = currentLocations..addAll(locations);
      _exploreLocationsNotifier.value = updatedLocations;
    });

    final cinemaService = GetIt.I<CinemaService>();
    cinemaService.cinemaExploreLocationsStream.listen((locations) {
      final currentLocations = List.of(_exploreLocationsNotifier.value);
      final updatedLocations = currentLocations..addAll(locations);

      _exploreLocationsNotifier.value = updatedLocations;
    });
    final roomfinderLocationsCubit = GetIt.I<RoomfinderCubit>();
    roomfinderLocationsCubit.roomfinderExploreLocationsStream.listen((locations) {
      final currentLocations = List.of(_exploreLocationsNotifier.value);
      final updatedLocations = currentLocations..addAll(locations);

      _exploreLocationsNotifier.value = updatedLocations;
    });
  }

  void dispose() {
    _selectedMarkerNotifier.dispose();
    _exploreLocationsNotifier.dispose();
  }

  void updateZoomLevel(double zoom) {
    final currentSize = _exploreMarkerSizeNotifier.value;
    if (zoom <= 14) {
      if (currentSize == ExploreMarkerSize.small) return;
      _exploreMarkerSizeNotifier.value = ExploreMarkerSize.small;
    } else if (zoom > 14 && zoom <= 16) {
      if (currentSize == ExploreMarkerSize.medium) return;
      _exploreMarkerSizeNotifier.value = ExploreMarkerSize.medium;
    } else {
      if (currentSize == ExploreMarkerSize.large) return;
      _exploreMarkerSizeNotifier.value = ExploreMarkerSize.large;
    }
  }

  void deselectMarker() {
    _selectedMarkerNotifier.value = null;
  }

  void updateMarker(String id) {
    final currentMarkers = List.of(_exploreLocationsNotifier.value);
    final selectedIndex = currentMarkers.indexWhere((element) => element.id == id);

    if (selectedIndex == -1) return;

    final selectedMarker = currentMarkers.removeAt(selectedIndex);
    currentMarkers.add(selectedMarker);

    _exploreLocationsNotifier.value = currentMarkers;
    _selectedMarkerNotifier.value = id;
  }

  void focusMarker(String id) {
    final location = _exploreLocationsNotifier.value.firstWhere((element) => element.id == id);
    final pos = LatLng(location.latitude, location.longitude);
    mapController.move(
      pos,
      17,
      offset: Offset(0, -100),
    );
    updateMarker(id);
  }
}

enum ExploreMarkerSize {
  small,
  medium,
  large,
}
