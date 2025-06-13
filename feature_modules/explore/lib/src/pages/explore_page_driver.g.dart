// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.3.5"

class _$TestExplorePageDriver extends TestDriver implements ExplorePageDriver {
  @override
  ScrollController filterScrollController = const _TestScrollController();

  @override
  MapController get mapController => const _TestMapController();

  @override
  List<ExploreLocation> get locations => [];

  @override
  LatLng get initialCenter => const LatLng(0, 0);

  @override
  ZoomConfig get zoomConfig => (initialZoom: 0, minZoom: 0, maxZoom: 0);

  @override
  CameraConstraint get cameraConstraint => const CameraConstraint.unconstrained();

  @override
  InteractionOptions get interactionOptions => const InteractionOptions();

  @override
  String get urlTemplate => "";

  @override
  List<String> get subdomains => [];

  @override
  TileProvider? get tileProvider => null;

  @override
  void onMapReady() {}

  @override
  void onPositionChanged(MapCamera camera, dynamic _) {}

  @override
  void onMapTap(dynamic _, dynamic __) {}

  @override
  void didInitDriver() {}

  @override
  void didUpdateBuildContext(BuildContext context) {}

  @override
  void dispose() {}
}

class $ExplorePageDriverProvider extends WidgetDriverProvider<ExplorePageDriver> {
  @override
  ExplorePageDriver buildDriver() {
    return ExplorePageDriver();
  }

  @override
  ExplorePageDriver buildTestDriver() {
    return _$TestExplorePageDriver();
  }
}
