import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_api/explore.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:widget_driver/widget_driver.dart';

import '../services/explore_location_service.dart';
import '../services/explore_map_service.dart';

part 'explore_page_driver.g.dart';

typedef ZoomConfig = ({double initialZoom, double minZoom, double maxZoom});

@GenerateTestDriver()
class ExplorePageDriver extends WidgetDriver {
  final _mapService = GetIt.I<ExploreMapService>();
  final _locationService = GetIt.I<ExploreLocationService>();

  late final ValueNotifier<List<ExploreLocation>> _filteredLocationsNotifier;
  late Brightness? _brightness;

  List<ExploreLocation> _locations = [];
  Style? _style;

  @TestDriverDefaultValue(_TestMapController())
  MapController get mapController => _mapService.mapController;

  @TestDriverDefaultValue([])
  List<ExploreLocation> get locations => _locations;

  @TestDriverDefaultValue(LatLng(0, 0))
  LatLng get initialCenter => const LatLng(48.150578, 11.580767);

  @TestDriverDefaultValue(null)
  Style? get style => _style;

  @TestDriverDefaultValue((initalZoom: 0, minZoom: 0, maxZoom: 0))
  ZoomConfig get zoomConfig => (initialZoom: 15, minZoom: 10, maxZoom: 18);

  @TestDriverDefaultValue(CameraConstraint.unconstrained())
  CameraConstraint get cameraConstraint => CameraConstraint.contain(bounds: _mapService.mapBounds);

  @TestDriverDefaultValue("")
  String get urlTemplate => _brightness == Brightness.light
      ? 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager_nolabels/{z}/{x}/{y}.png'
      : 'https://{s}.basemaps.cartocdn.com/rastertiles/dark_nolabels/{z}/{x}/{y}.png';

  @TestDriverDefaultValue([])
  List<String> get subdomains => const ['a', 'b', 'c'];

  void onMapReady() => _mapService.focusUserLocation(withAnimation: false);

  void onPositionChanged(MapCamera camera, _) => _mapService.updateZoomLevel(camera.zoom);

  void onMapTap(_, __) => _mapService.deselectMarker();

  void _initStyle() async {
    final style = await StyleReader(
      uri: 'mapbox://styles/mapbox/streets-v12?access_token={key}',
      apiKey: dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? '',
    ).read();
    _style = style;
    notifyWidget();
  }

  void _onExploreLocationsChanged() {
    _locations = _filteredLocationsNotifier.value;
    notifyWidget();
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _mapService.init();
    _locationService.init();

    _filteredLocationsNotifier = _locationService.filteredLocationsNotifier;
    _filteredLocationsNotifier.addListener(_onExploreLocationsChanged);

    _initStyle();
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _brightness = Theme.of(context).brightness;
  }

  @override
  void dispose() {
    _filteredLocationsNotifier.removeListener(_onExploreLocationsChanged);
    super.dispose();
  }
}

class _TestMapController extends EmptyDefault implements MapController {
  const _TestMapController();
}
