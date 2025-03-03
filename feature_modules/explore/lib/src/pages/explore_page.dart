import 'package:core/components.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart' as latlong;

import '../extensions/explore_marker_type_extension.dart';
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

  @override
  void initState() {
    super.initState();
    mapContentSheetController = ExploreMapContentSheetController();
    searchSheetController = LmuSearchSheetController();
  }

  @override
  Widget build(BuildContext context) {
    final mapService = GetIt.I<ExploreMapService>();

    return SoftBlur(
      child: Stack(
        children: [
          FlutterMap(
            mapController: mapService.mapController,
            options: MapOptions(
              backgroundColor: context.colors.neutralColors.backgroundColors.tile,
              initialCenter: const latlong.LatLng(48.150578, 11.580767),
              initialZoom: 15,
              onPositionChanged: (camera, _) => mapService.updateZoomLevel(camera.zoom),
              onTap: (_, __) {
                mapContentSheetController.close();
                mapService.deselectMarker();
              },
            ),
            children: [
              TileLayer(
                retinaMode: RetinaMode.isHighDensity(context),
                urlTemplate: 'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                additionalOptions: {
                  'accessToken': dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? '',
                  'id': MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? 'mapbox/dark-v10'
                      : 'mapbox/light-v10',
                },
              ),
              ValueListenableBuilder(
                valueListenable: mapService.exploreLocationsNotifier,
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
          ValueListenableBuilder(
            valueListenable: mapService.exploreLocationsNotifier,
            builder: (context, locations, _) {
              final searchEntrys = locations.map(
                (location) {
                  return LmuSearchEntry(
                    title: location.name,
                    subtitle: location.type.localizedName,
                    onTap: () {
                      mapService.focusMarker(location.id);
                      mapContentSheetController.open(location, fromSearch: true);
                    },
                    icon: location.type.icon,
                    iconColor: location.type.markerColor(context.colors),
                  );
                },
              ).toList();
              return LmuSearchSheet(
                searchEntries: searchEntrys,
                controller: searchSheetController,
              );
            },
          ),
          ExploreMapContentSheet(
            controller: mapContentSheetController,
            onClose: (fromSearch) {
              if (fromSearch) searchSheetController.openExtended(true);
            },
          )
        ],
      ),
    );
  }
}
