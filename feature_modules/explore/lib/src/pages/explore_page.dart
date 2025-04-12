import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart' as latlong;
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

    _mapService.animatedMapController = _animatedMapController;
  }

  Future<Style> _readStyle() {
    return StyleReader(
      uri: 'mapbox://styles/mapbox/streets-v12?access_token={key}',
      apiKey: "pk.eyJ1IjoiYml0dGVyc2Nob2tpIiwiYSI6ImNtOGltOW1lcDA1NjMya3F4c2Vta2tyenYifQ.yDusjqyBsYa4Lw325r_CBA",
    ).read();
  }

  void initStyle() async {
    style = await _readStyle();
    setState(() {});
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
              initialZoom: 15,
              onPositionChanged: (camera, _) => _mapService.updateZoomLevel(camera.zoom),
              onTap: (_, __) {
                _mapService.deselectMarker();
              },
            ),
            children: [
              TileLayer(
                retinaMode: RetinaMode.isHighDensity(context),
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/{id}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}',
                additionalOptions: {
                  'accessToken': dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? '',
                  'id': Theme.of(context).brightness == Brightness.light
                      ? 'lmu-dev/cm990f48l00ic01pge084c9aa'
                      : 'lmu-dev/cm990gii100ho01sk6f2hhh3m',
                },
              ),
              // if (style != null)
              //   VectorTileLayer(
              //     theme: style!.theme,
              //     sprites: style!.sprites,
              //     tileOffset: TileOffset.mapbox,
              //     tileProviders: style!.providers,
              //   ),

              CurrentLocationLayer(),
              ValueListenableBuilder(
                valueListenable: _mapService.exploreLocationsNotifier,
                builder: (context, locations, _) {
                  return MarkerLayer(
                    rotate: true,
                    markers: locations
                        .map(
                          (location) => Marker(
                            key: ValueKey(location.id),
                            width: 48,
                            height: 64,
                            alignment: Alignment.topCenter,
                            point: latlong.LatLng(location.latitude, location.longitude),
                            child: ExploreMarker(
                              exploreLocation: location,
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
              SafeArea(
                child: MapCompass(
                  icon: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colors.neutralColors.backgroundColors.tile,
                      border: Border.all(
                        color: context.colors.neutralColors.borderColors.iconOutline,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      LucideIcons.drafting_compass,
                      size: 24,
                    ),
                  ),
                  onPressed: () => _mapService.faceNorth(),
                  hideIfRotatedNorth: true,
                  padding: const EdgeInsets.only(top: 16, right: 16),
                ),
              ),
            ],
          ),
          const Positioned(
            right: 16,
            bottom: 16,
            child: ExploreMapOverlay(),
          ),
          const ExploreMapContentSheet(),
        ],
      ),
    );
  }
}
