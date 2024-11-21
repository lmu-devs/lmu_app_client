import 'package:core/constants.dart';
import 'package:flutter/material.dart' hide Visibility;
import 'package:get_it/get_it.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mensa/mensa.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:core/themes.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MapWithAnnotations();
  }
}

class AnnotationClickListener extends OnPointAnnotationClickListener {
  AnnotationClickListener({
    required this.onAnnotationClick,
  });

  final void Function(PointAnnotation annotation) onAnnotationClick;

  @override
  void onPointAnnotationClick(PointAnnotation annotation) {
    onAnnotationClick(annotation);
  }
}

class MapWithAnnotations extends StatefulWidget {
  const MapWithAnnotations({super.key});

  @override
  State<StatefulWidget> createState() => MapWithAnnotationsState();
}

class MapWithAnnotationsState extends State<MapWithAnnotations> {
  MapWithAnnotationsState();

  MapboxMap? mapboxMap;
  PointAnnotationManager? pointAnnotationManager;
  List<MensaModel> mensaData = [];
  Map<String, MensaModel> mensaPins = {};

  Future<void> _requestLocationPermission() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);

      PermissionStatus status = await Permission.location.request();
      if (status.isGranted) {
        print('Location permission granted');
      } else if (status.isDenied) {
        print('Location permission denied');
      } else if (status.isPermanentlyDenied) {
        await _showAppSettingsDialog();
      }
    }
  }

  Future<void> _showAppSettingsDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Permission Required"),
        content: Text("Location permission is required for this feature. Please allow it in settings."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await openAppSettings();
            },
            child: Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  Future<void> _addMarkersToMap(MapboxMap mapboxMap) async {
    final ByteData bytes = await rootBundle.load('feature_modules/explore/assets/mensa_pin.png');
    final Uint8List imageData = bytes.buffer.asUint8List();
    final MbxImage mbxImage = MbxImage(
      data: imageData,
      width: LmuSizes.small.floor(),
      height: LmuSizes.small.floor(),
    );

    await mapboxMap.style.addStyleImage(
      "mensa_pin",
      5,
      mbxImage,
      false,
      [],
      [],
      null,
    );
  }

  Future<void> _onMapCreated(MapboxMap mapboxMap) async {
    this.mapboxMap = mapboxMap;

    await _addMarkersToMap(mapboxMap);
    pointAnnotationManager = await mapboxMap.annotations.createPointAnnotationManager();

    var options = <PointAnnotationOptions>[];
    for (final mensa in mensaData) {
      var annotationOptions = PointAnnotationOptions(
        geometry: Point(
          coordinates: Position(
            mensa.location.longitude,
            mensa.location.latitude,
          ),
        ),
        iconImage: "mensa_pin",
        iconSize: 1,
      );

      options.add(annotationOptions);
    }

    List<PointAnnotation?>? annotations = await pointAnnotationManager?.createMulti(options);

    for (int i = 0; i < annotations!.length; i++) {
      mensaPins[annotations[i]!.id] = mensaData[i];
    }

    await pointAnnotationManager?.createMulti(options);

    pointAnnotationManager?.addOnPointAnnotationClickListener(
      AnnotationClickListener(
        onAnnotationClick: (annotation) {
          MensaModel? mensa = mensaPins[annotation.id];
          if (mensa != null) {
            print("Mensa name: ${mensa.name}");
          }

          mapboxMap.easeTo(
            CameraOptions(
              center: annotation.geometry,
              zoom: 14.0,
            ),
            MapAnimationOptions(
              duration: 4,
            ),
          );
        },
      ),
    );
  }

  String _getMapStyleUri(ThemeMode themeMode, BuildContext context) {
    const String mapStyleLight = MapboxStyles.MAPBOX_STREETS;
    const String mapStyleDark = MapboxStyles.DARK;

    if (themeMode == ThemeMode.light) {
      return mapStyleLight;
    } else if (themeMode == ThemeMode.dark) {
      return mapStyleDark;
    }

    return MediaQuery.of(context).platformBrightness == Brightness.light ? mapStyleLight : mapStyleDark;
  }

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
    mensaData = GetIt.I.get<MensaPublicApi>().mensaData;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        String mapStyleUri = _getMapStyleUri(themeProvider.themeMode, context);
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
    );
  }
}
