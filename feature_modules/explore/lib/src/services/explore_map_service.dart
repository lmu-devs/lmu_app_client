import 'package:flutter_map/flutter_map.dart';

class ExploreMapService {
  final _mapController = MapController();
  final _mapOptions = const MapOptions();

  MapController get mapController => _mapController;
  MapOptions get mapOptions => _mapOptions;
}
