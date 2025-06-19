import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/explore.dart';

import '../services/services.dart';

class ExplorePublicApi implements ExploreApi {
  @override
  void applyFilter(ExploreFilterType filter) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        final locationService = GetIt.I<ExploreLocationService>();
        locationService.applyInitialFilter(filter);
      } catch (e) {
        throw Exception("Filter [$filter] could not be applied: $e");
      }
    });
  }

  @override
  void selectLocation(String locationId) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        final mapService = GetIt.I<ExploreMapService>();
        mapService.selectedMarkerNotifier.value = locationId;
      } catch (e) {
        throw Exception("Location [$locationId] could not be applied: $e");
      }
    });
  }
}
