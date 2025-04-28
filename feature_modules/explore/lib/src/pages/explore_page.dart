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

class ExploreMapAnimationWrapper extends StatefulWidget {
  const ExploreMapAnimationWrapper({super.key});

  @override
  State<ExploreMapAnimationWrapper> createState() => _ExploreMapAnimationWrapperState();
}

class _ExploreMapAnimationWrapperState extends State<ExploreMapAnimationWrapper> with TickerProviderStateMixin {
  late final AnimatedMapController _animatedMapController;

  @override
  void initState() {
    super.initState();
    final mapService = GetIt.I<ExploreMapService>();

    _animatedMapController = AnimatedMapController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      mapController: mapService.mapController,
    );
    mapService.animatedMapController = _animatedMapController;
  }

  @override
  Widget build(BuildContext context) => ExplorePage();
}

class ExplorePage extends DrivableWidget<ExplorePageDriver> {
  ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
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
            ),
            children: [
              TileLayer(
                urlTemplate: driver.urlTemplate,
                subdomains: driver.subdomains,
                // tileProvider: CachedTileProvider(
                //   maxStale: const Duration(days: 30),
                //   store: HiveCacheStore("erter"),
                // ),
              ),
              // if (style != null)
              //   VectorTileLayer(
              //     theme: style!.theme,
              //     sprites: style!.sprites,
              //     tileOffset: TileOffset.mapbox,
              //     tileProviders: style!.providers,
              //     layerMode: VectorTileLayerMode.vector,
              //     showTileDebugInfo: true,
              //     logCacheStats: true,
              //   ),
              CurrentLocationLayer(),
              MarkerLayer(rotate: true, markers: driver.locations.map((location) => location.toMarker).toList()),
              // MarkerClusterLayerWidget(
              //   options: MarkerClusterLayerOptions(
              //     maxClusterRadius: 50,
              //     size: const Size(36, 36),
              //     alignment: Alignment.center,
              //     padding: const EdgeInsets.all(50),
              //     maxZoom: 15,
              //     markers: markers,
              //     builder: (context, markers) {
              //       return Container(
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(20),
              //           border: Border.all(
              //             color: context.colors.neutralColors.borderColors.iconOutline,
              //             width: 1.5,
              //           ),
              //           color: context.colors.neutralColors.backgroundColors.tile,
              //         ),
              //         child: Center(
              //           child: LmuText.bodySmall(
              //             markers.length.toString(),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
              Positioned(
                bottom: 0,
                width: MediaQuery.of(context).size.width,
                child: const ExploreMapOverlay(),
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
