import 'package:flutter/material.dart' hide Visibility;
import 'package:get_it/get_it.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mensa/mensa.dart';
import 'package:provider/provider.dart';
import 'package:core/themes.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MapWithAnnotations();
  }
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

class MapWithAnnotations extends StatefulWidget {
  const MapWithAnnotations();

  @override
  State<StatefulWidget> createState() => MapWithAnnotationsState();
}

class MapWithAnnotationsState extends State<MapWithAnnotations> {
  MapWithAnnotationsState();

  MapboxMap? mapboxMap;
  CircleAnnotation? circleAnnotation;
  CircleAnnotationManager? circleAnnotationManager;
  int styleIndex = 1;
  List<MensaLocationData> mensaLocations = [];

  void _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
    mapboxMap.annotations.createCircleAnnotationManager().then((value) {
      circleAnnotationManager = value;
      var options = <CircleAnnotationOptions>[];
      for (final location in mensaLocations) {
        options.add(
          CircleAnnotationOptions(
            geometry: Point(
              coordinates: Position(
                location.longitude,
                location.latitude,
              ),
            ),
            circleRadius: 12.0,
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
                duration: 4,
              ),
            );
            circleAnnotation = annotation;
          },
        ),
      );
    });
  }

  String getMapStyleUri(ThemeMode themeMode, BuildContext context) {
    const String mapStyleLight = 'mapbox://styles/mapbox/streets-v11';
    const String mapStyleDark = 'mapbox://styles/mapbox/dark-v10';

    if (themeMode == ThemeMode.light) {
      return mapStyleLight;
    } else if (themeMode == ThemeMode.dark) {
      return mapStyleDark;
    }

    return MediaQuery.of(context).platformBrightness == Brightness.light
        ? mapStyleLight
        : mapStyleDark;
  }


  @override
  void initState() {
    super.initState();
    mensaLocations = GetIt.I.get<MensaPublicApi>().testLocations;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          String mapStyleUri = getMapStyleUri(themeProvider.themeMode, context);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mapboxMap != null) {
              mapboxMap!.loadStyleURI(mapStyleUri);
            }
          });

          return MapWidget(
            key: const ValueKey("mapWidget"),
            styleUri: mapStyleUri,
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
        },
      ),
    );
  }
}
