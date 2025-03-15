import 'dart:async';

import 'package:core/core_services.dart';
import 'package:core/logging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';

class LocationService with ChangeNotifier {
  LocationService() {
    init();
  }
  final _appLogger = AppLogger();
  final _locationSettings = const LocationSettings(accuracy: LocationAccuracy.best, distanceFilter: 50);

  Position? _currentLocation;
  StreamSubscription<List<Position>>? positionStream;

  Future<void> init() async {
    final hasPermission = await PermissionsService.isLocationPermissionGranted();
    final isLocationServiceEnabled = await PermissionsService.isLocationServicesEnabled();
    if (!hasPermission || !isLocationServiceEnabled) return;

    _currentLocation = await Geolocator.getCurrentPosition(locationSettings: _locationSettings);
    _appLogger.logMessage('[LocationService]: Initial location: $_currentLocation');
    notifyListeners();

    positionStream = Geolocator.getPositionStream(locationSettings: _locationSettings).distinct().pairwise().listen(
      (pair) {
        final previous = pair.first;
        final current = pair.last;

        if (previous.latitude != current.latitude || previous.longitude != current.longitude) {
          _currentLocation = current;
          _appLogger.logMessage('[LocationService]: Location updated: $current');
          notifyListeners();
        }
      },
    );
  }

  Future<void> updatePosition() async {
    _currentLocation = await Geolocator.getCurrentPosition(locationSettings: _locationSettings);
    _appLogger.logMessage('[LocationService]: Updated location: $_currentLocation');
    notifyListeners();
  }

  @override
  Future<void> dispose() async {
    await positionStream?.cancel();
    super.dispose();
  }

  double? getDistance({required double lat, required double long}) {
    if (_currentLocation == null) return null;
    return Geolocator.distanceBetween(_currentLocation!.latitude, _currentLocation!.longitude, lat, long);
  }
}

extension DistanceFormatter on double {
  String formatDistance() {
    if (this < 1000) {
      int roundedMeters = (this / 50).round() * 50;
      return '$roundedMeters m';
    } else if (this < 10000) {
      return '${(this / 1000).toStringAsFixed(1)} km';
    } else {
      return '${(this / 1000).toInt()} km';
    }
  }
}
