// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.3.3"

class _$TestExplorePageDriver extends TestDriver implements ExplorePageDriver {
  @override
  MapController get mapController => _TestMapController();

  @override
  List<ExploreLocation> get locations => [];

  @override
  LatLng get initialCenter => LatLng(0, 0);

  @override
  Style? get style => null;

  @override
  ZoomConfig get zoomConfig => (initialZoom: 0, minZoom: 0, maxZoom: 0);

  @override
  CameraConstraint get cameraConstraint => CameraConstraint.unconstrained();

  @override
  String get urlTemplate => "";

  @override
  List<String> get subdomains => [];

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
