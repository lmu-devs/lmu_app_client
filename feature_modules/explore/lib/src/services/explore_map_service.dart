import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart' as latlong;
import 'package:shared_api/cinema.dart';
import 'package:shared_api/explore.dart';
import 'package:shared_api/mensa.dart';

class ExploreMapService {
  void init() {
    _mapController = MapController();
    _mapOptions = MapOptions(
      initialCenter: const latlong.LatLng(48.151775, 11.570614),
      initialZoom: 14,
      onTap: (tapPosition, point) {
        _selectedMarkerNotifier.value = null;
      },
    );

    _loadExploreLocations();
  }

  MapController get mapController => _mapController;
  MapOptions get mapOptions => _mapOptions;
  ValueNotifier<String?> get selectedMarkerNotifier => _selectedMarkerNotifier;
  ValueNotifier<List<ExploreLocation>> get exploreLocationsNotifier => _exploreLocationsNotifier;

  final ValueNotifier<String?> _selectedMarkerNotifier = ValueNotifier(null);

  final ValueNotifier<List<ExploreLocation>> _exploreLocationsNotifier = ValueNotifier([]);

  late final MapOptions _mapOptions;
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
  }

  void dispose() {
    _selectedMarkerNotifier.dispose();
    _exploreLocationsNotifier.dispose();
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
}
