import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart' as latlong;
import 'package:shared_api/explore.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';

import '../services/explore_map_service.dart';
import '../widgets/explore_map_content_sheet.dart';
import '../widgets/explore_map_overlay.dart';
import '../widgets/explore_marker.dart';
import '../widgets/explore_marker_animation.dart';
import '../widgets/explore_marker_wave.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with TickerProviderStateMixin {
  late final AnimatedMapController _animatedMapController;
  late final DraggableScrollableController _sheetController;
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
    _mapService.exploreLocationsNotifier
        .addListener(_onExploreLocationsChanged);

    _mapService.animatedMapController = _animatedMapController;

    _sheetController = DraggableScrollableController();
  }

  void _onExploreLocationsChanged() {
    setState(() {
      markers = _mapService.exploreLocationsNotifier.value
          .map((location) => location.toMarker)
          .toList();
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
    _mapService.exploreLocationsNotifier
        .removeListener(_onExploreLocationsChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locationStream =
        const LocationMarkerDataStreamFactory().fromGeolocatorPositionStream();

    return SoftBlur(
      child: Stack(
        children: [
          FlutterMap(
            mapController: _animatedMapController.mapController,
            options: MapOptions(
              backgroundColor:
                  context.colors.neutralColors.backgroundColors.tile,
              initialCenter: const latlong.LatLng(48.150578, 11.580767),
              cameraConstraint:
                  CameraConstraint.contain(bounds: _mapService.mapBounds),
              initialZoom: 15,
              maxZoom: 18,
              minZoom: 10,
              onMapReady: () =>
                  _mapService.focusUserLocation(withAnimation: false),
              onPositionChanged: (camera, _) =>
                  _mapService.updateZoomLevel(camera.zoom),
              onTap: (_, __) => _mapService.deselectMarker(),
            ),
            children: [
              // Base tile layer (lowest z-index)
              TileLayer(
                urlTemplate: Theme.of(context).brightness == Brightness.light
                    ? 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager_nolabels/{z}/{x}/{y}.png'
                    : 'https://{s}.basemaps.cartocdn.com/rastertiles/dark_nolabels/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),

              // Marker selection wave positioned below markers (2nd lowest z-index)
              ValueListenableBuilder<String?>(
                valueListenable: _mapService.selectedMarkerNotifier,
                builder: (context, selectedMarkerId, _) {
                  // Return early if no marker is selected
                  if (selectedMarkerId == null) {
                    return const SizedBox.shrink();
                  }

                  // Find the selected location
                  final locations = _mapService.exploreLocationsNotifier.value;
                  ExploreLocation? selectedLocation;
                  try {
                    selectedLocation = locations.firstWhere(
                      (loc) => loc.id == selectedMarkerId,
                    );
                  } catch (_) {
                    // Location not found
                  }

                  // Return empty if location not found
                  if (selectedLocation == null) {
                    return const SizedBox.shrink();
                  }

                  return MarkerWave(
                    selectedMarkerPosition: latlong.LatLng(
                      selectedLocation.latitude,
                      selectedLocation.longitude,
                    ),
                    color: Colors.blue,
                    baseMinRadius: 10,
                    baseMaxRadius: 500,
                    duration: const Duration(milliseconds: 5000),
                    opacity: 0.4,
                    blurIntensity: 5.0,
                    numberOfCircles: 3,
                    transformY: -10.0,
                    repeat: false,
                    delay: const Duration(milliseconds: 300),
                  );
                },
              ),

              // Pulsating radar layer
              PulsatingRadarLayer(
                locationStream: locationStream,
                baseMinRadius: 10,
                baseMaxRadius: 3000,
                duration: const Duration(seconds: 10),
                opacity: 0.3,
                color: Colors.blue,
                numberOfCircles: 3,
                blurIntensity: 5.0,
                gradientStartOpacity: 0.8,
                gradientEndOpacity: 0.0,
                maxZoomLevel: 20.0,
                zoomScaleFactor: 1.2,
              ),

              // Current location layer
              CurrentLocationLayer(
                positionStream: locationStream,
              ),

              // Marker layer (highest z-index for map elements)
              MarkerLayer(rotate: true, markers: markers),

              // UI overlay elements
              Positioned(
                bottom: 0,
                width: MediaQuery.of(context).size.width,
                child: const ExploreMapOverlay(),
              ),
            ],
          ),
          ExploreMapContentSheet(sheetController: _sheetController),
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
