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
  Map<PointAnnotation, MensaModel> mensaPins = {};
  PointAnnotation? previouslySelectedAnnotation;
  final ValueNotifier<MensaModel?> selectedMensaNotifier = ValueNotifier<MensaModel?>(null);

  late final DraggableScrollableController _sheetController;
  late final ValueNotifier<int> _sheetSizeNotifier;

  Future<void> _loadMarkerImages(MapboxMap mapboxMap, BuildContext context) async {
    final List<String> pinTypes = ['mensa_pin', 'bistro_pin', 'cafe_pin'];

    for (final pinType in pinTypes) {
      final ByteData imageBytes =
          await rootBundle.load(getPngAssetTheme(context, 'feature_modules/explore/assets/$pinType'));

      await mapboxMap.style.addStyleImage(
        pinType,
        6,
        MbxImage(
          data: imageBytes.buffer.asUint8List(),
          width: LmuSizes.small.floor(),
          height: LmuSizes.small.floor(),
        ),
        false,
        [],
        [],
        null,
      );
    }
  }

  String _getMarkerByType(MensaType mensaType) {
    switch (mensaType) {
      case MensaType.mensa:
        return 'mensa_pin';
      case MensaType.stuBistro:
        return 'bistro_pin';
      default:
        return 'cafe_pin';
    }
  }

  Future<void> _addMarkers(MapboxMap mapboxMap) async {
    await _loadMarkerImages(mapboxMap, context);
    await pointAnnotationManager?.deleteAll();

    var options = <PointAnnotationOptions>[];

    for (final mensa in mensaData) {
      var annotationOptions = PointAnnotationOptions(
        geometry: Point(
          coordinates: Position(
            mensa.location.longitude,
            mensa.location.latitude,
          ),
        ),
        iconImage: _getMarkerByType(mensa.type),
        iconSize: selectedMensaNotifier.value?.canteenId == mensa.canteenId ? 1.5 : 1.0,
      );

      options.add(annotationOptions);
    }

    List<PointAnnotation?>? annotations = await pointAnnotationManager?.createMulti(options);

    if (annotations != null) {
      mensaPins.clear();
      for (int i = 0; i < annotations.length; i++) {
        if (annotations[i] != null) {
          mensaPins[annotations[i]!] = mensaData[i];
        }
      }
    }
  }

  Future<void> _updateMarkers(MapboxMap mapboxMap) async {
    await _loadMarkerImages(mapboxMap, context);

    for (final mensaPin in mensaPins.entries) {
      mensaPin.key.iconImage = _getMarkerByType(mensaPin.value.type);
    }
  }

  Future<void> _configureAttribution(MapboxMap mapboxMap, BuildContext context) async {
    await Future.wait(
      [
        mapboxMap.attribution.updateSettings(
          AttributionSettings(
            marginBottom: _sheetSizeNotifier.value + LmuSizes.medium,
            marginRight: LmuSizes.medium,
            position: OrnamentPosition.BOTTOM_RIGHT,
            iconColor: context.colors.neutralColors.textColors.weakColors.base.value,
          ),
        ),
        mapboxMap.logo.updateSettings(
          LogoSettings(
            marginBottom: _sheetSizeNotifier.value + LmuSizes.medium,
            marginLeft: LmuSizes.medium,
            position: OrnamentPosition.BOTTOM_LEFT,
          ),
        ),
      ],
    );
  }

  Future<void> _configureScale(MapboxMap mapboxMap) async {
    await mapboxMap.scaleBar.updateSettings(
      ScaleBarSettings(enabled: false),
    );
  }

  Future<void> _onMapCreated(MapboxMap mapboxMap) async {
    this.mapboxMap = mapboxMap;

    await _configureAttribution(mapboxMap, context);
    await _configureScale(mapboxMap);
    await _addMarkers(mapboxMap);
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
        iconImage: _getMarkerByType(mensa.type),
        iconSize: selectedMensaNotifier.value?.canteenId == mensa.canteenId ? 1.5 : 1.0,
      );

      options.add(annotationOptions);
    }

    List<PointAnnotation?>? annotations = await pointAnnotationManager?.createMulti(options);

    for (int i = 0; i < annotations!.length; i++) {
      mensaPins[annotations[i]!] = mensaData[i];
    }

    await pointAnnotationManager?.createMulti(options);

    pointAnnotationManager?.addOnPointAnnotationClickListener(
      AnnotationClickListener(
        onAnnotationClick: (annotation) async {
          MapEntry<PointAnnotation, MensaModel>? mapEntry =
              mensaPins.entries.cast<MapEntry<PointAnnotation, MensaModel>?>().firstWhere(
                    (entry) => entry?.key.id == annotation.id,
                    orElse: () => null,
                  );

          MensaModel? selectedMensa = mapEntry?.value;

          if (selectedMensa != null) {
            selectedMensaNotifier.value = selectedMensa;

            if (previouslySelectedAnnotation != null) {
              await pointAnnotationManager?.update(
                previouslySelectedAnnotation!..iconSize = 1.0,
              );
            }

            await pointAnnotationManager?.update(
              annotation..iconSize = 1.5,
            );

            previouslySelectedAnnotation = annotation;
          }

          mapboxMap.easeTo(
            CameraOptions(
              center: annotation.geometry,
            ),
            MapAnimationOptions(
              duration: 60,
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
    mensaData = GetIt.I.get<MensaPublicApi>().mensaData;
    _sheetController = DraggableScrollableController();
    _sheetSizeNotifier = ValueNotifier<int>(0);

    _sheetSizeNotifier.addListener(() {
      if (mapboxMap != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await _configureAttribution(mapboxMap!, context);
        });
      }
    });

    _sheetController.addListener(() {
      int newSize = (_sheetController.sizeToPixels(_sheetController.size)).ceil();
      if (_sheetSizeNotifier.value != newSize) {
        _sheetSizeNotifier.value = newSize;
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sheetSizeNotifier.value = _sheetController.sizeToPixels(_sheetController.size).ceil();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _sheetController.dispose();
    _sheetSizeNotifier.dispose();
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
                _updateMarkers(mapboxMap!);
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
