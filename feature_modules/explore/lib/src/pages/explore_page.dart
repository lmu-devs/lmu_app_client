import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart' as latlong;

import '../services/explore_map_service.dart';
import '../widgets/explore_map_bottom_sheet.dart';
import '../widgets/explore_marker.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final mapService = GetIt.I<ExploreMapService>();

    return Stack(
      children: [
        FlutterMap(
          mapController: mapService.mapController,
          options: MapOptions(
            backgroundColor: context.colors.neutralColors.backgroundColors.tile,
            initialCenter: const latlong.LatLng(48.150578, 11.580767),
            initialZoom: 15,
            onPositionChanged: (camera, _) => mapService.updateZoomLevel(camera.zoom),
            onTap: (_, __) => mapService.deselectMarker(),
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
              builder: (context, locations, child) {
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
                          child: ExploreMarker(exploreLocation: location),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
        const ExploreMapBottomSheet(),
      ],
    );
  }
}
