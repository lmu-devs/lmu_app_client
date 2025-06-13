import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:get_it/get_it.dart';
import 'package:http_cache_hive_store/http_cache_hive_store.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_api/explore.dart';
import 'package:widget_driver/widget_driver.dart';

import '../services/explore_location_service.dart';
import '../services/explore_map_service.dart';

part 'explore_page_driver.g.dart';

typedef ZoomConfig = ({double initialZoom, double minZoom, double maxZoom});

@GenerateTestDriver()
class ExplorePageDriver extends WidgetDriver {
  final _mapService = GetIt.I<ExploreMapService>();
  final _locationService = GetIt.I<ExploreLocationService>();

  @TestDriverDefaultValue(_TestScrollController())
  late final ScrollController filterScrollController;

  late final ValueNotifier<List<ExploreLocation>> _filteredLocationsNotifier;
  late Brightness _brightness;
  TileProvider? _tileProvider;

  List<ExploreLocation> _locations = [];

  @TestDriverDefaultValue(_TestMapController())
  MapController get mapController => _mapService.mapController;

  @TestDriverDefaultValue([])
  List<ExploreLocation> get locations => _locations;

  @TestDriverDefaultValue(LatLng(0, 0))
  LatLng get initialCenter => const LatLng(48.150578, 11.580767);

  @TestDriverDefaultValue((initialZoom: 0, minZoom: 0, maxZoom: 0))
  ZoomConfig get zoomConfig => (initialZoom: 15, minZoom: 10, maxZoom: 18);

  @TestDriverDefaultValue(CameraConstraint.unconstrained())
  CameraConstraint get cameraConstraint => CameraConstraint.contain(bounds: _mapService.mapBounds);

  @TestDriverDefaultValue(InteractionOptions())
  InteractionOptions get interactionOptions => const InteractionOptions(rotationThreshold: 40);

  @TestDriverDefaultValue("")
  String get urlTemplate => _brightness == Brightness.light
      ? 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager_nolabels/{z}/{x}/{y}.png'
      : 'https://{s}.basemaps.cartocdn.com/rastertiles/dark_nolabels/{z}/{x}/{y}.png';

  @TestDriverDefaultValue([])
  List<String> get subdomains => const ['a', 'b', 'c'];

  @TestDriverDefaultValue(null)
  TileProvider? get tileProvider => _tileProvider;

  void onMapReady() => _mapService.focusUserLocation(withAnimation: false);

  void onPositionChanged(MapCamera camera, _) => _mapService.updateZoomLevel(camera.zoom);

  void onMapTap(_, __) => _mapService.deselectMarker();

  void _onExploreLocationsChanged() {
    _locations = _filteredLocationsNotifier.value;
    notifyWidget();
  }

  Future<String> _getCacheDirectory() async {
    final dir = await getTemporaryDirectory();
    return '${dir.path}${Platform.pathSeparator}MapTiles';
  }

  Future<TileProvider> _initTileProvider() async {
    final cacheDirectory = await _getCacheDirectory();

    return CachedTileProvider(
      maxStale: const Duration(days: 30),
      store: HiveCacheStore(cacheDirectory, hiveBoxName: 'HiveCacheStore'),
    );
  }

  void _scrollToInitialFilter() {
    final initialFilters = _locationService.filterNotifier.value;

    if (initialFilters.isNotEmpty && initialFilters.first == ExploreFilterType.library) {

      if (filterScrollController.hasClients) {
        final maxScroll = filterScrollController.position.maxScrollExtent;

        filterScrollController.animateTo(
          maxScroll,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  void didInitDriver() async {
    super.didInitDriver();
    _mapService.init();
    _locationService.init();

    filterScrollController = ScrollController();

    _filteredLocationsNotifier = _locationService.filteredLocationsNotifier;
    _filteredLocationsNotifier.addListener(_onExploreLocationsChanged);
    _tileProvider = await _initTileProvider();

    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToInitialFilter());
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _brightness = Theme.of(context).brightness;
  }

  @override
  void dispose() {
    _filteredLocationsNotifier.removeListener(_onExploreLocationsChanged);
    filterScrollController.dispose();
    super.dispose();
  }
}

class _TestScrollController extends EmptyDefault implements ScrollController {
  const _TestScrollController();
}

class _TestMapController extends EmptyDefault implements MapController {
  const _TestMapController();
}
