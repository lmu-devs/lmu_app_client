import 'package:flutter/material.dart' hide Visibility;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExampleMap();
  }
}

class ExampleMap extends StatelessWidget {
  const ExampleMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapWidget(
        key: const ValueKey("mapWidget"),
        cameraOptions: CameraOptions(
          center: Point(
            coordinates: Position(
              11.582,
              48.1351,
            ),
          ),
          zoom: 12.0,
        ),
      ),
    );
  }
}
