import 'dart:async';

import 'package:core/logging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';

import '../repository/api/models/mensa/mensa_location.dart';

class MensaDistanceService with ChangeNotifier {
  final _appLogger = AppLogger();
  final _locationSettings = const LocationSettings(accuracy: LocationAccuracy.best, distanceFilter: 50);

  Position? _currentLocation;
  StreamSubscription<List<Position>>? positionStream;

  Future<void> init() async {
    _currentLocation = await Geolocator.getCurrentPosition(locationSettings: _locationSettings);
    _appLogger.logMessage('[MensaDistanceService]: Initial location: $_currentLocation');
    notifyListeners();

    positionStream = Geolocator.getPositionStream(locationSettings: _locationSettings).distinct().pairwise().listen(
      (pair) {
        final previous = pair.first;
        final current = pair.last;

        if (previous.latitude != current.latitude || previous.longitude != current.longitude) {
          _currentLocation = current;
          _appLogger.logMessage('[MensaDistanceService]: Location updated: $current');
          notifyListeners();
        }
      },
    );
  }

  @override
  Future<void> dispose() async {
    await positionStream?.cancel();
    super.dispose();
  }

  double? getDistanceToMensa(MensaLocation mensaLocation) {
    if (_currentLocation == null) return null;
    return Geolocator.distanceBetween(
      _currentLocation!.latitude,
      _currentLocation!.longitude,
      mensaLocation.latitude,
      mensaLocation.longitude,
    );
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
