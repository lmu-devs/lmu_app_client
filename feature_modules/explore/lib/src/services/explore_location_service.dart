import 'dart:async';

import 'package:core/logging.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/cinema.dart';
import 'package:shared_api/explore.dart';
import 'package:shared_api/libraries.dart';
import 'package:shared_api/mensa.dart';
import 'package:shared_api/roomfinder.dart';

class ExploreLocationService {
  final Completer<void> _initialLoadCompleter = Completer<void>();
  late final Future<void> onInitialLoad;
  bool _isInitialized = false;

  final ValueNotifier<List<ExploreLocation>> _locationsNotifier = ValueNotifier([]);
  final ValueNotifier<List<ExploreLocation>> _filteredLocationsNotifier = ValueNotifier([]);
  final ValueNotifier<List<ExploreFilterType>> _filterNotifier = ValueNotifier([]);
  final ValueNotifier<ExploreFilterType?> initialScrollRequestNotifier = ValueNotifier(null);

  ValueNotifier<List<ExploreLocation>> get exploreLocationsNotifier => _locationsNotifier;
  ValueNotifier<List<ExploreLocation>> get filteredLocationsNotifier => _filteredLocationsNotifier;
  ValueNotifier<List<ExploreFilterType>> get filterNotifier => _filterNotifier;

  void init() {
    if (_isInitialized) return;

    onInitialLoad = _initialLoadCompleter.future;
    _loadExploreLocations();
    _isInitialized = true;
  }

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

  void applyInitialFilter(ExploreFilterType type) {
    _filterNotifier.value = [type];
    _updateFilteredExploreLocations();
    initialScrollRequestNotifier.value = type;
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

  void clearScrollRequest() {
    initialScrollRequestNotifier.value = null;
  }

  void _loadExploreLocations() {
    final allSourceStreams = <Stream<List<ExploreLocation>>>[
      GetIt.I<MensaService>().mensaExploreLocationsStream,
      GetIt.I<CinemaService>().cinemaExploreLocationsStream,
      GetIt.I<RoomfinderService>().roomfinderExploreLocationsStream,
      GetIt.I<LibrariesService>().librariesExploreLocationsStream,
    ];

    final deliveredStreams = <Stream>{};

    for (final stream in allSourceStreams) {
      stream.listen(
            (locations) {
          if (!deliveredStreams.contains(stream)) {
            deliveredStreams.add(stream);
            if (deliveredStreams.length == allSourceStreams.length) {
              if (!_initialLoadCompleter.isCompleted) {
                _initialLoadCompleter.complete();
              }
            }
          }

          final currentLocations = List.of(_locationsNotifier.value);
          final currentIds = currentLocations.map((l) => l.id).toSet();
          final uniqueNewLocations = locations.where((l) => !currentIds.contains(l.id));

          if (uniqueNewLocations.isNotEmpty) {
            _locationsNotifier.value = [...currentLocations, ...uniqueNewLocations];
            _updateFilteredExploreLocations();
          }
        },
        onError: (error) {
          if (!_initialLoadCompleter.isCompleted) {
            _initialLoadCompleter.completeError(error);
            AppLogger().logMessage("ExploreLocationService: A stream failed. Error: $error");
          }
        },
      );
    }
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
