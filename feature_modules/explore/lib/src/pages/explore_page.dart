import 'package:core/components.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart' as latlong;
import 'package:vector_map_tiles/vector_map_tiles.dart';

import '../routes/explore_routes.dart';
import '../services/explore_map_service.dart';
import '../widgets/explore_map_content_sheet.dart';
import '../widgets/explore_marker.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late final ExploreMapContentSheetController mapContentSheetController;
  late final LmuSearchSheetController searchSheetController;
  late final Stream<double?> alignPositionStream;
  Style? style;
  final _mapService = GetIt.I<ExploreMapService>();

  @override
  void initState() {
    super.initState();
    _mapService.init();

    initStyle();

    mapContentSheetController = ExploreMapContentSheetController();
    searchSheetController = LmuSearchSheetController();
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
            mapController: _mapService.mapController,
            options: MapOptions(
              backgroundColor: context.colors.neutralColors.backgroundColors.tile,
              initialCenter: const latlong.LatLng(48.150578, 11.580767),
              initialZoom: 15,
              onPositionChanged: (camera, _) => _mapService.updateZoomLevel(camera.zoom),
              onTap: (_, __) {
                mapContentSheetController.close();
                _mapService.deselectMarker();
              },
            ),
            children: [
              // TileLayer(
              //   retinaMode: RetinaMode.isHighDensity(context),
              //   urlTemplate: 'https://api.mapbox.com/styles/v1/{id}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}',
              //   additionalOptions: {
              //     'accessToken': dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? '',
              //     'id': Theme.of(context).brightness == Brightness.light
              //         ? 'lmu-dev/cm990f48l00ic01pge084c9aa'
              //         : 'lmu-dev/cm990gii100ho01sk6f2hhh3m',
              //   },
              // ),
              if (style != null)
                VectorTileLayer(
                  theme: style!.theme,
                  sprites: style!.sprites,
                  tileOffset: TileOffset.mapbox,
                  tileProviders: style!.providers,
                ),
              CurrentLocationLayer(
                style: LocationMarkerStyle(
                  showAccuracyCircle: false,
                  marker: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF1A95F3),
                      border: Border.all(
                        color: context.colors.neutralColors.borderColors.iconOutline,
                        width: 2,
                      ),
                    ),
                  ),
                  markerSize: const Size(24, 24),
                  markerDirection: MarkerDirection.heading,
                ),
              ),
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
                              onActive: (fromSearch) {
                                mapContentSheetController.open(location, fromSearch: fromSearch);
                              },
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ],
          ),
          // MapActionButton(
          //   icon: LucideIcons.compass,
          //   sheetHeight: 168,
          //   onTap: () => _mapService.focuUserLocation(),
          // ),
          // MapActionButton(
          //   icon: LucideIcons.map_pin,
          //   sheetHeight: 114,
          //   onTap: () => _mapService.focuUserLocation(),
          // ),
          // MapActionButton(
          //   icon: LucideIcons.layers,
          //   sheetHeight: 66,
          //   onTap: () => () {},
          // ),
          // MapActionButton(
          //   icon: LucideIcons.search,
          //   sheetHeight: 16,
          //   onTap: () => () {},
          // ),
          // ValueListenableBuilder(
          //   valueListenable: _mapService.exploreLocationsNotifier,
          //   builder: (context, locations, _) {
          //     final searchEntrys = locations.map(
          //       (location) {
          //         return LmuSearchEntry(
          //           title: location.name,
          //           subtitle: location.type.localizedName,
          //           onTap: () {
          //             _mapService.focusMarker(location.id);
          //             mapContentSheetController.open(location, fromSearch: true);
          //           },
          //           icon: location.type.icon,
          //           iconColor: location.type.markerColor(context.colors),
          //         );
          //       },
          //     ).toList();
          //     return LmuSearchSheet(
          //       searchEntries: searchEntrys,
          //       controller: searchSheetController,
          //     );
          //   },
          // ),
          Positioned(
            right: 16,
            bottom: 16,
            child: LmuIconButton(
              icon: LucideIcons.search,
              backgroundColor: context.colors.neutralColors.backgroundColors.tile,
              onPressed: () => const ExploreSearchRoute().go(context),
            ),
          ),
          ExploreMapContentSheet(
            controller: mapContentSheetController,
            onClose: (fromSearch) {
              if (fromSearch) searchSheetController.openExtended(true);
            },
          ),
        ],
      ),
    );
  }
}
