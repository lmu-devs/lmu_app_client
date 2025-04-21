import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart' as latlong;
import 'package:shared_api/explore.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';

import '../services/explore_map_service.dart';
import '../widgets/explore_compass.dart';
import '../widgets/explore_map_content_sheet.dart';
import '../widgets/explore_map_overlay.dart';
import '../widgets/explore_marker.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> with TickerProviderStateMixin {
  late final AnimatedMapController _animatedMapController;
  Style? style;
  List<Marker> markers = [];
  final _mapService = GetIt.I<ExploreMapService>();

  @override
  void initState() {
    super.initState();
    _mapService.init();

    initStyle();

    _animatedMapController = AnimatedMapController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      mapController: _mapService.mapController,
    );

    _onExploreLocationsChanged();
    _mapService.exploreLocationsNotifier.addListener(_onExploreLocationsChanged);

    _mapService.animatedMapController = _animatedMapController;
  }

  void _onExploreLocationsChanged() {
    setState(() {
      markers = _mapService.exploreLocationsNotifier.value.map((location) => location.toMarker).toList();
    });
  }

  Future<Style> _readStyle() {
    return StyleReader(
      uri: 'mapbox://styles/mapbox/streets-v12?access_token={key}',
      apiKey: dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? '',
    ).read();
  }

  void initStyle() async {
    style = await _readStyle();
    setState(() {});
  }

  @override
  void dispose() {
    _mapService.exploreLocationsNotifier.removeListener(_onExploreLocationsChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SoftBlur(
      child: Stack(
        children: [
          FlutterMap(
            mapController: _animatedMapController.mapController,
            options: MapOptions(
              backgroundColor: context.colors.neutralColors.backgroundColors.tile,
              initialCenter: const latlong.LatLng(48.150578, 11.580767),
              cameraConstraint: CameraConstraint.contain(bounds: _mapService.mapBounds),
              initialZoom: 15,
              maxZoom: 18,
              minZoom: 10,
              onMapReady: () => _mapService.focuUserLocation(withAnimation: false),
              onPositionChanged: (camera, _) => _mapService.updateZoomLevel(camera.zoom),
              onTap: (_, __) => _mapService.deselectMarker(),
            ),
            children: [
              TileLayer(
                urlTemplate: MediaQuery.of(context).platformBrightness == Brightness.light
                    ? 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager_nolabels/{z}/{x}/{y}.png'
                    : 'https://{s}.basemaps.cartocdn.com/rastertiles/dark_nolabels/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
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
              MarkerLayer(rotate: true, markers: markers),
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
              SafeArea(
                child: MapCompass(
                  alignment: Alignment.topRight,
                  icon: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colors.neutralColors.backgroundColors.tile,
                    ),
                    child: const Icon(LucideIcons.drafting_compass, size: 20),
                  ),
                  onPressed: () => _mapService.faceNorth(),
                  hideIfRotatedNorth: true,
                  padding: const EdgeInsets.only(top: LmuSizes.size_8, right: LmuSizes.size_8),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: const ExploreMapOverlay(),
          ),
          const ExploreMapContentSheet(),
        ],
      ),
    );
  }
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
