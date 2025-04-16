import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_api/cinema.dart';
import 'package:shared_api/explore.dart';
import 'package:shared_api/mensa.dart';
import 'package:shared_api/roomfinder.dart';

enum ExploreLocationFilter { mensa, building, cinema }

class ExploreMapService {
  void init() {
    _mapController = MapController();

    _loadExploreLocations();
  }

  AnimatedMapController? animatedMapController;

  MapController get mapController => _mapController;
  ValueNotifier<String?> get selectedMarkerNotifier => _selectedMarkerNotifier;
  ExploreLocation? get selectedMarker =>
      _exploreLocationsNotifier.value.firstWhereOrNull((element) => element.id == _selectedMarkerNotifier.value);
  ValueNotifier<List<ExploreLocation>> get exploreLocationsNotifier => _exploreLocationsNotifier;
  ValueNotifier<List<ExploreLocation>> get allExploreLocationsNotifier => _allExploreLocationsNotifier;
  ValueNotifier<ExploreMarkerSize> get exploreMarkerSizeNotifier => _exploreMarkerSizeNotifier;

  final ValueNotifier<String?> _selectedMarkerNotifier = ValueNotifier(null);

  final ValueNotifier<List<ExploreLocationFilter>> _exploreLocationFilterNotifier =
      ValueNotifier(ExploreLocationFilter.values);
  ValueNotifier<List<ExploreLocationFilter>> get exploreLocationFilterNotifier => _exploreLocationFilterNotifier;

  final ValueNotifier<List<ExploreLocation>> _exploreLocationsNotifier = ValueNotifier([]);
  final ValueNotifier<List<ExploreLocation>> _allExploreLocationsNotifier = ValueNotifier([]);
  final ValueNotifier<ExploreMarkerSize> _exploreMarkerSizeNotifier = ValueNotifier(ExploreMarkerSize.medium);
  late final MapController _mapController;

  List<ExploreLocation> _availableLocations = [];

  void _loadExploreLocations() {
    final mensaService = GetIt.I<MensaService>();
    mensaService.mensaExploreLocationsStream.listen((locations) {
      final currentLocations = List.of(_availableLocations);
      final updatedLocations = currentLocations..addAll(locations);
      _availableLocations = updatedLocations;

      _updateFilteredExploreLocations();
    });

    final cinemaService = GetIt.I<CinemaService>();
    cinemaService.cinemaExploreLocationsStream.listen((locations) {
      final currentLocations = List.of(_availableLocations);
      final updatedLocations = currentLocations..addAll(locations);
      _availableLocations = updatedLocations;
      _updateFilteredExploreLocations();
    });
    final roomfinderService = GetIt.I<RoomfinderService>();
    roomfinderService.roomfinderExploreLocationsStream.listen((locations) {
      final currentLocations = List.of(_availableLocations);
      final updatedLocations = currentLocations..addAll(locations);
      _availableLocations = updatedLocations;
      _updateFilteredExploreLocations();
    });
  }

  void dispose() {
    _selectedMarkerNotifier.dispose();
    _exploreLocationsNotifier.dispose();
  }

  void updateZoomLevel(double zoom) {
    final currentSize = _exploreMarkerSizeNotifier.value;
    if (zoom <= 13) {
      if (currentSize == ExploreMarkerSize.small) return;
      _exploreMarkerSizeNotifier.value = ExploreMarkerSize.small;
    } else if (zoom > 13 && zoom <= 15) {
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

    animatedMapController?.animateTo(
      dest: LatLng(selectedMarker.latitude, selectedMarker.longitude),
      zoom: _mapController.camera.zoom <= 13 ? 16 : _mapController.camera.zoom,
    );
  }

  void focusMarker(String id) {
    final location = _exploreLocationsNotifier.value.firstWhere((element) => element.id == id);
    final pos = LatLng(location.latitude, location.longitude);

    if (animatedMapController != null) {
      animatedMapController!.animateTo(dest: pos, zoom: 16);
    }
    updateMarker(id);
  }

  void focuUserLocation() async {
    final currentUserLocation = await Geolocator.getCurrentPosition();
    if (animatedMapController != null) {
      animatedMapController!.animateTo(
        dest: LatLng(currentUserLocation.latitude, currentUserLocation.longitude),
        zoom: 16,
      );
    }
  }

  void faceNorth() {
    if (animatedMapController != null) {
      animatedMapController!.animatedRotateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void updateFilter(ExploreLocationFilter filter) {
    final currentFilter = List.of(_exploreLocationFilterNotifier.value);
    if (currentFilter.contains(filter)) {
      currentFilter.remove(filter);
    } else {
      currentFilter.add(filter);
    }
    _exploreLocationFilterNotifier.value = currentFilter;
    _updateFilteredExploreLocations();
  }

  void _updateFilteredExploreLocations() {
    allExploreLocationsNotifier.value = _availableLocations;

    final filters = _exploreLocationFilterNotifier.value;

    if (filters.isEmpty) {
      _exploreLocationsNotifier.value = _availableLocations;
      return;
    }

    final filtered = _availableLocations.where((location) {
      return filters.any((filter) {
        switch (filter) {
          case ExploreLocationFilter.mensa:
            return location.type == ExploreMarkerType.mensaMensa ||
                location.type == ExploreMarkerType.mensaStuBistro ||
                location.type == ExploreMarkerType.mensaStuCafe ||
                location.type == ExploreMarkerType.mensaStuLounge;
          case ExploreLocationFilter.building:
            return location.type == ExploreMarkerType.roomfinderRoom;
          case ExploreLocationFilter.cinema:
            return location.type == ExploreMarkerType.cinema;
        }
      });
    }).toList();

    _exploreLocationsNotifier.value = filtered;
  }
}

enum ExploreMarkerSize {
  small,
  medium,
  large,
}
