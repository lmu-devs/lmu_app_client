
import 'package:core/constants.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart' hide Visibility;
import 'package:get_it/get_it.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mensa/mensa.dart';
import 'package:provider/provider.dart';
import 'package:core/themes.dart';
import 'package:flutter/services.dart';

import '../widgets/map_bottom_sheet.dart';

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
  PointAnnotation? previouslySelectedAnnotation;
  final ValueNotifier<MensaModel?> selectedMensaNotifier = ValueNotifier<MensaModel?>(null);
  final DraggableScrollableController _sheetController = DraggableScrollableController();

  Future<void> _addMarkersToMap(MapboxMap mapboxMap) async {
    final List<String> pinTypes = ['mensa_pin', 'bistro_pin', 'cafe_pin'];

    for (final pinType in pinTypes) {
      final ByteData bytes =
          await rootBundle.load(getPngAssetTheme(context, 'feature_modules/explore/assets/$pinType'));
      final Uint8List imageData = bytes.buffer.asUint8List();
      final MbxImage mbxImage = MbxImage(
        data: imageData,
        width: LmuSizes.small.floor(),
        height: LmuSizes.small.floor(),
      );

      await mapboxMap.style.addStyleImage(
        pinType,
        7,
        mbxImage,
        false,
        [],
        [],
        null,
      );
    }

    await pointAnnotationManager?.deleteAll();

    var options = <PointAnnotationOptions>[];

    for (final mensa in mensaData) {
      final String pinType = _getPinTypeForMensa(mensa.type);
      var annotationOptions = PointAnnotationOptions(
        geometry: Point(
          coordinates: Position(
            mensa.location.longitude,
            mensa.location.latitude,
          ),
        ),
        iconImage: pinType,
        iconSize: selectedMensaNotifier.value?.canteenId == mensa.canteenId ? 1.5 : 1.0,
      );

      options.add(annotationOptions);
    }

    List<PointAnnotation?>? annotations = await pointAnnotationManager?.createMulti(options);

    if (annotations != null) {
      mensaPins.clear();
      for (int i = 0; i < annotations.length; i++) {
        if (annotations[i] != null) {
          mensaPins[annotations[i]!.id] = mensaData[i];
        }
      }
    }
  }

  String _getPinTypeForMensa(MensaType mensaType) {
    switch (mensaType) {
      case MensaType.mensa:
        return 'mensa_pin';
      case MensaType.stuBistro:
        return 'bistro_pin';
      default:
        return 'cafe_pin';
    }
  }

  Future<void> _configureAttribution(MapboxMap mapboxMap, BuildContext context) async {
    Color attributionColor;

    if (Provider.of<ThemeProvider>(context, listen: false).themeMode == ThemeMode.light) {
      attributionColor = Colors.black;
    } else if (Provider.of<ThemeProvider>(context, listen: false).themeMode == ThemeMode.dark) {
      attributionColor = Colors.white;
    } else {
      attributionColor = MediaQuery.of(context).platformBrightness == Brightness.light ? Colors.black : Colors.white;
    }

    await mapboxMap.attribution.updateSettings(
      AttributionSettings(
        marginTop: LmuSizes.large,
        position: OrnamentPosition.TOP_LEFT,
        iconColor: attributionColor.value,
      ),
    );
  }

  Future<void> _onMapCreated(MapboxMap mapboxMap) async {
    this.mapboxMap = mapboxMap;

    await _configureAttribution(mapboxMap, context);
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
        iconImage: _getPinTypeForMensa(mensa.type),
        iconSize: selectedMensaNotifier.value?.canteenId == mensa.canteenId ? 1.5 : 1.0,
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
        onAnnotationClick: (annotation) async {
          MensaModel? selectedMensa = mensaPins[annotation.id];

          if (selectedMensa != null) {
            selectedMensaNotifier.value = selectedMensa;

            if (previouslySelectedAnnotation != null) {
              // Check if the previouslySelectedAnnotation still exists
              await pointAnnotationManager?.update(
                previouslySelectedAnnotation!..iconSize = 1.0,
              );
            }

            await pointAnnotationManager?.update(
              annotation..iconSize = 1.5,
            );

            previouslySelectedAnnotation = annotation;

            mapboxMap.easeTo(
              CameraOptions(
                center: annotation.geometry,
              ),
              MapAnimationOptions(
                duration: 8,
              ),
            );
          }
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
    mensaData = GetIt.I.get<MensaPublicApi>().mensaData;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<MensaModel?>(
      valueListenable: selectedMensaNotifier,
      builder: (context, selectedMensa, child) {
        if (selectedMensa == null && previouslySelectedAnnotation != null) {
          pointAnnotationManager?.update(
            previouslySelectedAnnotation!..iconSize = 1.0,
          );
          previouslySelectedAnnotation = null;
        }

        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            String mapStyleUri = _getMapStyleUri(themeProvider.themeMode, context);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mapboxMap != null) {
                mapboxMap!.loadStyleURI(mapStyleUri);
                _configureAttribution(mapboxMap!, context);
                _addMarkersToMap(mapboxMap!);
              }
            });

            return Stack(
              children: [
                SoftBlur(
                  child: MapWidget(
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
                  ),
                ),
                MapBottomSheet(
                  selectedMensaNotifier: selectedMensaNotifier,
                  sheetController: _sheetController,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
