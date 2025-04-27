import 'dart:async';

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
import 'dart:math' as math;

enum ExploreLocationFilter { mensa, building, library, cinema }

class ExploreMapService {
  void init() {
    _mapController = MapController();

    _mapController.mapEventStream.listen((event) async {
      final isFocused = await isUserLocationFocused();
      _isUserFocusedNotifier.value = isFocused;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startCameraRotationPolling();
    });

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

  final ValueNotifier<List<ExploreLocationFilter>> _exploreLocationFilterNotifier = ValueNotifier([]);

  ValueNotifier<List<ExploreLocationFilter>> get exploreLocationFilterNotifier => _exploreLocationFilterNotifier;

  final ValueNotifier<List<ExploreLocation>> _exploreLocationsNotifier = ValueNotifier([]);
  final ValueNotifier<List<ExploreLocation>> _allExploreLocationsNotifier = ValueNotifier([]);
  final ValueNotifier<ExploreMarkerSize> _exploreMarkerSizeNotifier = ValueNotifier(ExploreMarkerSize.medium);
  late final MapController _mapController;

  final ValueNotifier<bool> _isUserFocusedNotifier = ValueNotifier(false);

  ValueNotifier<bool> get isUserFocusedNotifier => _isUserFocusedNotifier;

  final ValueNotifier<String> _compassDirectionNotifier = ValueNotifier("N");

  ValueNotifier<String> get compassDirectionNotifier => _compassDirectionNotifier;

  List<ExploreLocation> _availableLocations = [];

  LatLngBounds get mapBounds => LatLngBounds(
        const LatLng(47.5, 11.2), // SW
        const LatLng(48.6, 12.3), // NE
      );

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
    _isUserFocusedNotifier.dispose();
    _compassDirectionNotifier.dispose();
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
      offset: const Offset(0, -60),
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

  Future<bool> isUserLocationFocused({double thresholdInMeters = 20}) async {
    try {
      final userPosition = await Geolocator.getCurrentPosition();
      final center = _mapController.camera.center;

      final distance = const Distance().as(
        LengthUnit.Meter,
        LatLng(userPosition.latitude, userPosition.longitude),
        center,
      );

      return distance <= thresholdInMeters;
    } catch (e) {
      return false;
    }
  }

  Future<bool> focusUserLocation({bool withAnimation = true}) async {
    final currentUserLocation = await Geolocator.getCurrentPosition();

    if (currentUserLocation.latitude < mapBounds.southWest.latitude ||
        currentUserLocation.latitude > mapBounds.northEast.latitude ||
        currentUserLocation.longitude < mapBounds.southWest.longitude ||
        currentUserLocation.longitude > mapBounds.northEast.longitude) {
      return false;
    }

    if (animatedMapController != null) {
      if (withAnimation) {
        animatedMapController!.animateTo(
          dest: LatLng(currentUserLocation.latitude, currentUserLocation.longitude),
          zoom: 16,
        );
      } else {
        mapController.move(LatLng(currentUserLocation.latitude, currentUserLocation.longitude), 15);
      }
    }
    return true;
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

  void _startCameraRotationPolling() {
    double previousRotation = _mapController.camera.rotationRad;

    Timer.periodic(const Duration(milliseconds: 100), (_) {
      double currentRotation = _mapController.camera.rotationRad;
      if (currentRotation != previousRotation) {
        _updateCompassDirection(currentRotation);
        previousRotation = currentRotation;
      }
    });
  }

  void _updateCompassDirection(double rotationRad) {
    double degrees = (rotationRad * 180 / math.pi) % 360;
    if (degrees < 0) degrees += 360;

    String direction;
    if (degrees >= 315 || degrees < 45) {
      direction = "N";
    } else if (degrees >= 45 && degrees < 135) {
      direction = "E";
    } else if (degrees >= 135 && degrees < 225) {
      direction = "S";
    } else {
      direction = "W";
    }

    if (_compassDirectionNotifier.value != direction) {
      _compassDirectionNotifier.value = direction;
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
            return location.type == ExploreMarkerType.roomfinderBuilding;
          case ExploreLocationFilter.cinema:
            return location.type == ExploreMarkerType.cinema;
          case ExploreLocationFilter.library:
            return location.type == ExploreMarkerType.library;
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
