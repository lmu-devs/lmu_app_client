import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart' as latlong;
import 'package:shared_api/explore.dart';
import 'package:widget_driver/widget_driver.dart';

import '../services/explore_map_service.dart';
import '../widgets/explore_map_content_sheet.dart';
import '../widgets/explore_map_overlay.dart';
import '../widgets/explore_marker.dart';
import 'explore_page_driver.dart';

/// This [ExploreMapAnimationWrapper] is needed since [DrivableWidget] does not support [TickerProviderStateMixin],
/// which is needed for the animated map controller
class ExploreMapAnimationWrapper extends StatefulWidget {
  const ExploreMapAnimationWrapper({super.key});

  @override
  State<ExploreMapAnimationWrapper> createState() => _ExploreMapAnimationWrapperState();
}

class _ExploreMapAnimationWrapperState extends State<ExploreMapAnimationWrapper> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    final mapService = GetIt.I<ExploreMapService>();

    final animatedMapController = AnimatedMapController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      mapController: mapService.mapController,
    );
    mapService.animatedMapController = animatedMapController;
  }

  @override
  Widget build(BuildContext context) => ExplorePage();
}

class ExplorePage extends DrivableWidget<ExplorePageDriver> {
  ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SoftBlur(
      child: Stack(
        children: [
          FlutterMap(
            mapController: driver.mapController,
            options: MapOptions(
              backgroundColor: context.colors.neutralColors.backgroundColors.tile,
              initialCenter: driver.initialCenter,
              cameraConstraint: driver.cameraConstraint,
              initialZoom: driver.zoomConfig.initialZoom,
              minZoom: driver.zoomConfig.minZoom,
              maxZoom: driver.zoomConfig.maxZoom,
              onMapReady: driver.onMapReady,
              onPositionChanged: driver.onPositionChanged,
              onTap: driver.onMapTap,
              interactionOptions: driver.interactionOptions,
            ),
            children: [
              TileLayer(
                urlTemplate: driver.urlTemplate,
                subdomains: driver.subdomains,
                tileProvider: driver.tileProvider,
              ),
              const CurrentLocationLayer(),
              MarkerLayer(
                  rotate: true,
                  markers: driver.locations
                      .map((location) => location.toMarker)
                      .toList()),
              Positioned(
                bottom: 0,
                width: screenWidth,
                child: ExploreMapOverlay(
                  filterScrollController: driver.filterScrollController,
                ),
              ),
            ],
          ),
          const ExploreMapContentSheet(),
        ],
      ),
    );
  }

  @override
  WidgetDriverProvider<ExplorePageDriver> get driverProvider => $ExplorePageDriverProvider();
}

extension on ExploreLocation {
  Marker get toMarker {
    return Marker(
      key: ValueKey(id),
      width: 48,
      height: 108,
      alignment: Alignment.center,
      point: latlong.LatLng(latitude, longitude),
      child: ExploreMarker(exploreLocation: this),
    );
  }
}
