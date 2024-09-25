import 'package:flutter/material.dart' hide Visibility;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MensaMapRoute extends StatelessWidget {
  const MensaMapRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAnnotationPage();
  }
}

abstract class ExamplePage extends StatelessWidget {
  const ExamplePage(this.leading, this.title);

  final Widget leading;
  final String title;
}

class CircleAnnotationPage extends ExamplePage {
  CircleAnnotationPage() : super(const Icon(Icons.map), 'Circle Annotations');

  @override
  Widget build(BuildContext context) {
    return const CircleAnnotationPageBody();
  }
}

class CircleAnnotationPageBody extends StatefulWidget {
  const CircleAnnotationPageBody();

  @override
  State<StatefulWidget> createState() => CircleAnnotationPageBodyState();
}

class AnnotationClickListener extends OnCircleAnnotationClickListener {
  AnnotationClickListener({
    required this.onAnnotationClick,
  });

  final void Function(CircleAnnotation annotation) onAnnotationClick;

  @override
  void onCircleAnnotationClick(CircleAnnotation annotation) {
    print("onAnnotationClick, id: ${annotation.id}");
    onAnnotationClick(annotation);
  }
}

class CircleAnnotationPageBodyState extends State<CircleAnnotationPageBody> {
  CircleAnnotationPageBodyState();

  MapboxMap? mapboxMap;
  CircleAnnotation? circleAnnotation;
  CircleAnnotationManager? circleAnnotationManager;
  int styleIndex = 1;

  _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
    mapboxMap.annotations.createCircleAnnotationManager().then((value) {
      circleAnnotationManager = value;
      createOneAnnotation();

      var options = <CircleAnnotationOptions>[];
      for (var i = 0; i < 10; i++) {
        options.add(
          CircleAnnotationOptions(
            geometry: Point(
              coordinates: Position(
                11.5820,
                48.1351 + i * 0.01,
              ),
            ),
            circleRadius: 8.0,
          ),
        );
      }
      circleAnnotationManager?.createMulti(options);
      circleAnnotationManager?.addOnCircleAnnotationClickListener(
        AnnotationClickListener(
          onAnnotationClick: (annotation) {
            mapboxMap.easeTo(
              CameraOptions(
                center: annotation.geometry,
                zoom: 14.0,
              ),
              MapAnimationOptions(
                duration: 2,
              ),
            );
            circleAnnotation = annotation;
          },
        ),
      );
    });
  }

  void createOneAnnotation() {
    circleAnnotationManager
        ?.create(
          CircleAnnotationOptions(
            geometry: Point(
              coordinates: Position(
                11.5820,
                48.1351,
              ),
            ),
            circleColor: Colors.yellow.value,
            circleRadius: 12.0,
          ),
        )
        .then((value) => circleAnnotation = value);
    ;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MapWidget mapWidget = MapWidget(
      key: ValueKey("mapWidget"),
      onMapCreated: _onMapCreated,
      cameraOptions: CameraOptions(
        center: Point(
          coordinates: Position(
            11.582,
            48.1351,
          ),
        ),
        zoom: 12.0,
      ),
    );

    final colmn = mapWidget;

    return Scaffold(
      body: colmn,
    );
  }
}
