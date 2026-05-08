import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/explore.dart';

import '../services/services.dart';

class ExplorePublicApi implements ExploreApi {
  @override
  void applyFilter(ExploreFilterType filter) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final locationService = GetIt.I<ExploreLocationService>();
        await locationService.onInitialLoad;
        locationService.applyInitialFilter(filter);
      } catch (e) {
        throw Exception("Filter [$filter] could not be applied: $e");
      }
    });
  }

  @override
  void selectLocation(String locationId) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final mapService = GetIt.I<ExploreMapService>();
        final locationService = GetIt.I<ExploreLocationService>();

        await locationService.onInitialLoad;
        final location = locationService.getLocationById(locationId);

        mapService.selectedMarkerNotifier.value = locationId;
        mapService.focusMarker(location);
        locationService.bringToFront(locationId);
        locationService.ensureLocationVisible(location);
      } catch (e) {
        throw Exception("Location [$locationId] could not be applied: $e");
      }
    });
  }
}
