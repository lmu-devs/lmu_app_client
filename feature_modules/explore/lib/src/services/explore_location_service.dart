import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/cinema.dart';
import 'package:shared_api/explore.dart';
import 'package:shared_api/libraries.dart';
import 'package:shared_api/mensa.dart';
import 'package:shared_api/roomfinder.dart';

enum ExploreFilterType { mensa, building, library, cinema }

class ExploreLocationService {
  final ValueNotifier<List<ExploreLocation>> _locationsNotifier = ValueNotifier([]);
  final ValueNotifier<List<ExploreLocation>> _filteredLocationsNotifier = ValueNotifier([]);
  final ValueNotifier<List<ExploreFilterType>> _filterNotifier = ValueNotifier([]);

  ValueNotifier<List<ExploreLocation>> get exploreLocationsNotifier => _locationsNotifier;
  ValueNotifier<List<ExploreLocation>> get filteredLocationsNotifier => _filteredLocationsNotifier;
  ValueNotifier<List<ExploreFilterType>> get filterNotifier => _filterNotifier;

  void init() => _loadExploreLocations();

  ExploreLocation getLocationById(String id) => _locationsNotifier.value.firstWhere((location) => location.id == id);

  void bringToFront(String id) {
    final location = _filteredLocationsNotifier.value.firstWhere((location) => location.id == id);
    final currentLocations = List.of(_filteredLocationsNotifier.value);
    currentLocations.remove(location);
    currentLocations.add(location);
    _filteredLocationsNotifier.value = currentLocations;
  }

  void ensureLocationVisible(ExploreLocation location) {
    final currentLocations = List.of(_filteredLocationsNotifier.value);
    if (!currentLocations.contains(location)) {
      currentLocations.add(location);
      _filteredLocationsNotifier.value = currentLocations;
    }
  }

  void updateFilter(ExploreFilterType type) {
    final currentFilters = List.of(_filterNotifier.value);
    if (currentFilters.contains(type)) {
      currentFilters.remove(type);
    } else {
      currentFilters.add(type);
    }
    _filterNotifier.value = currentFilters;
    _updateFilteredExploreLocations();
  }

  void _loadExploreLocations() {
    final mensaService = GetIt.I<MensaService>();
    mensaService.mensaExploreLocationsStream.listen((locations) {
      final currentLocations = List.of(_locationsNotifier.value);
      final updatedLocations = currentLocations..addAll(locations);
      _locationsNotifier.value = updatedLocations;
      _updateFilteredExploreLocations();
    });

    final cinemaService = GetIt.I<CinemaService>();
    cinemaService.cinemaExploreLocationsStream.listen((locations) {
      final currentLocations = List.of(exploreLocationsNotifier.value);
      final updatedLocations = currentLocations..addAll(locations);
      exploreLocationsNotifier.value = updatedLocations;
      _updateFilteredExploreLocations();
    });
    final roomfinderService = GetIt.I<RoomfinderService>();
    roomfinderService.roomfinderExploreLocationsStream.listen((locations) {
      final currentLocations = List.of(exploreLocationsNotifier.value);
      final updatedLocations = currentLocations..addAll(locations);
      exploreLocationsNotifier.value = updatedLocations;
      _updateFilteredExploreLocations();
    });
    final librariesService = GetIt.I<LibrariesService>();
    librariesService.librariesExploreLocationsStream.listen((locations) {
      final currentLocations = List.of(exploreLocationsNotifier.value);
      final updatedLocations = currentLocations..addAll(locations);
      exploreLocationsNotifier.value = updatedLocations;
      _updateFilteredExploreLocations();
    });
  }

  void _updateFilteredExploreLocations() {
    final filters = _filterNotifier.value;

    if (filters.isEmpty) {
      _filteredLocationsNotifier.value = List.of(_locationsNotifier.value);
      return;
    }

    final filtered = _locationsNotifier.value.where((location) {
      return filters.any((filter) {
        switch (filter) {
          case ExploreFilterType.mensa:
            return location.type == ExploreMarkerType.mensaMensa ||
                location.type == ExploreMarkerType.mensaStuBistro ||
                location.type == ExploreMarkerType.mensaStuCafe ||
                location.type == ExploreMarkerType.mensaStuLounge;
          case ExploreFilterType.building:
            return location.type == ExploreMarkerType.roomfinderBuilding;
          case ExploreFilterType.library:
            return location.type == ExploreMarkerType.library;
          case ExploreFilterType.cinema:
            return location.type == ExploreMarkerType.cinema;
        }
      });
    }).toList();

    _filteredLocationsNotifier.value = filtered;
  }
}
