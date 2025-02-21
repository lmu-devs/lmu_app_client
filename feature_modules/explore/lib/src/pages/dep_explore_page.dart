import 'dart:ui';

import 'package:core/constants.dart';
import 'package:core/permissions.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart' hide Visibility;
import 'package:flutter/services.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:get_it/get_it.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:shared_api/mensa.dart';

import '../widgets/map_action_button.dart';
import '../widgets/map_bottom_sheet_sizes.dart';

class DepExplorePage extends StatelessWidget {
  const DepExplorePage({super.key});

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
  CameraOptions? spawnLocation;
  PointAnnotationManager? pointAnnotationManager;
  PointAnnotation? previouslySelectedAnnotation;
  final int animationToLocationDuration = 240;

  List<MensaLocationData> mensaData = [];
  Map<PointAnnotation, MensaLocationData> mensaPins = {};
  final ValueNotifier<MensaLocationData?> selectedMensaNotifier = ValueNotifier<MensaLocationData?>(null);
  final themeProvider = GetIt.I.get<ThemeProvider>();

  late final DraggableScrollableController _sheetController;
  late final ValueNotifier<double> _sheetSizeNotifier;

  Future<void> _loadMarkerImages(MapboxMap mapboxMap, BuildContext context) async {
    final List<String> pinTypes = ['mensa_pin', 'bistro_pin', 'cafe_pin', 'espresso_pin'];

    for (final pinType in pinTypes) {
      if (context.mounted) {
        final ByteData imageBytes = await rootBundle.load(
          getPngAssetTheme('feature_modules/explore/assets/$pinType'),
        );

        Uint8List image = imageBytes.buffer.asUint8List();
        final parsedImage = await decodeImageFromList(image);
        final mbxImage = MbxImage(data: image, height: parsedImage.height, width: parsedImage.width);

        await mapboxMap.style.addStyleImage(
          pinType,
          6,
          mbxImage,
          false,
          [],
          [],
          null,
        );
      }
    }
  }

  String _getMarkerByType(MensaType mensaType) {
    return switch (mensaType) {
      MensaType.mensa => 'mensa_pin',
      MensaType.stuBistro => 'bistro_pin',
      MensaType.stuCafe => 'cafe_pin',
      MensaType.cafeBar => 'espresso_pin',
      MensaType.lounge => 'mensa_pin',
      MensaType.none => 'mensa_pin',
    };
  }

  Future<void> _addMarkers(MapboxMap mapboxMap) async {
    await _loadMarkerImages(mapboxMap, context);
    await pointAnnotationManager?.deleteAll();

    var options = <PointAnnotationOptions>[];

    for (final mensa in mensaData) {
      var annotationOptions = PointAnnotationOptions(
        geometry: Point(
          coordinates: Position(
            mensa.longitude,
            mensa.latitude,
          ),
        ),
        iconImage: _getMarkerByType(mensa.type),
        iconSize: selectedMensaNotifier.value?.id == mensa.id ? 1.5 : 1.0,
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

  Future<void> _addUserLocation(MapboxMap mapboxMap) async {
    await mapboxMap.location.updateSettings(
      LocationComponentSettings(
        enabled: true,
        pulsingEnabled: true,
        showAccuracyRing: true,
      ),
    );
  }

  Future<CameraOptions> _getUserLocation() async {
    Point targetLocation;

    try {
      geo.Position position = await geo.Geolocator.getCurrentPosition();

      targetLocation = Point(
        coordinates: Position(
          position.longitude,
          position.latitude,
        ),
      );
    } catch (e) {
      targetLocation = Point(
        coordinates: Position(
          11.575328,
          48.137371,
        ),
      );
    }

    return CameraOptions(
      center: targetLocation,
      zoom: 13.5,
    );
  }

  Future<void> _configureAttributionElements(MapboxMap mapboxMap) async {
    await Future.wait(
      [
        mapboxMap.logo.updateSettings(
          LogoSettings(
            marginBottom: _sheetSizeNotifier.value + LmuSizes.size_72,
            marginLeft: LmuSizes.size_12,
            position: OrnamentPosition.BOTTOM_LEFT,
          ),
        ),
        mapboxMap.attribution.updateSettings(
          AttributionSettings(
            marginBottom: _sheetSizeNotifier.value + LmuSizes.size_72,
            marginLeft: LmuSizes.size_32,
            position: OrnamentPosition.BOTTOM_LEFT,
            iconColor: Colors.transparent.value,
          ),
        ),
      ],
    );
  }

  Future<void> _configureGeoElements(MapboxMap mapboxMap) async {
    await Future.wait(
      [
        mapboxMap.scaleBar.updateSettings(
          ScaleBarSettings(enabled: false),
        ),
        mapboxMap.compass.updateSettings(
          CompassSettings(
            marginBottom: _sheetSizeNotifier.value + LmuSizes.size_112,
            marginRight: LmuSizes.size_12,
            position: OrnamentPosition.BOTTOM_RIGHT,
          ),
        ),
      ],
    );
  }

  Future<void> _onMapCreated(MapboxMap mapboxMap) async {
    this.mapboxMap = mapboxMap;

    await _configureAttributionElements(mapboxMap);
    await _configureGeoElements(mapboxMap);
    await _addUserLocation(mapboxMap);
    await _addMarkers(mapboxMap);

    pointAnnotationManager = await mapboxMap.annotations.createPointAnnotationManager();

    var options = <PointAnnotationOptions>[];
    for (final mensa in mensaData) {
      var annotationOptions = PointAnnotationOptions(
        geometry: Point(
          coordinates: Position(
            mensa.longitude,
            mensa.latitude,
          ),
        ),
        iconImage: _getMarkerByType(mensa.type),
        iconSize: selectedMensaNotifier.value?.id == mensa.id ? 1.5 : 1.0,
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
          MapEntry<PointAnnotation, MensaLocationData>? mapEntry =
              mensaPins.entries.cast<MapEntry<PointAnnotation, MensaLocationData>?>().firstWhere(
                    (entry) => entry?.key.id == annotation.id,
                    orElse: () => null,
                  );

          MensaLocationData? selectedMensa = mapEntry?.value;

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
              duration: animationToLocationDuration,
            ),
          );
        },
      ),
    );
  }

  String _getMapStyleUri(ThemeMode themeMode) {
    const String mapStyleLight = MapboxStyles.MAPBOX_STREETS;
    const String mapStyleDark = MapboxStyles.DARK;

    if (themeMode == ThemeMode.light) {
      return mapStyleLight;
    } else if (themeMode == ThemeMode.dark) {
      return mapStyleDark;
    }

    return PlatformDispatcher.instance.platformBrightness == Brightness.light ? mapStyleLight : mapStyleDark;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      spawnLocation = await _getUserLocation();
      await mapboxMap?.setCamera(spawnLocation!);
    });

    mensaData = [];
    _sheetController = DraggableScrollableController();
    _sheetSizeNotifier = ValueNotifier<double>(0.0);

    _sheetSizeNotifier.addListener(() {
      if (mapboxMap != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await _configureAttributionElements(mapboxMap!);
          await _configureGeoElements(mapboxMap!);
        });
      }
    });

    _sheetController.addListener(() {
      double newSize = double.parse(_sheetController.sizeToPixels(_sheetController.size).toStringAsFixed(2));
      if (_sheetSizeNotifier.value != newSize && newSize <= _sheetController.sizeToPixels(SheetSizes.medium.size)) {
        _sheetSizeNotifier.value = newSize;
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sheetSizeNotifier.value = double.parse(
        _sheetController.sizeToPixels(_sheetController.size).toStringAsFixed(2),
      );
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
    return ValueListenableBuilder<MensaLocationData?>(
      valueListenable: selectedMensaNotifier,
      builder: (context, selectedMensa, child) {
        if (selectedMensa == null && previouslySelectedAnnotation != null) {
          pointAnnotationManager?.update(
            previouslySelectedAnnotation!..iconSize = 1.0,
          );
          previouslySelectedAnnotation = null;
        }

        return ListenableBuilder(
          listenable: themeProvider,
          builder: (context, child) {
            String mapStyleUri = _getMapStyleUri(themeProvider.themeMode);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mapboxMap != null) {
                mapboxMap!.loadStyleURI(mapStyleUri);
                _configureAttributionElements(mapboxMap!);
                _updateMarkers(mapboxMap!);
              }
            });

            return Stack(
              children: [
                SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: SoftBlur(
                      child: MapWidget(
                        key: const ValueKey("mapWidget"),
                        styleUri: mapStyleUri,
                        onMapCreated: _onMapCreated,
                        cameraOptions: spawnLocation,
                      ),
                    ),
                  ),
                ),
                ValueListenableBuilder(
                    valueListenable: _sheetSizeNotifier,
                    builder: (context, sheetSize, child) {
                      return MapActionButton(
                        icon: LucideIcons.map_pin,
                        sheetHeight: sheetSize,
                        onTap: () async {
                          bool dontCenter = false;
                          await PermissionsService.isLocationPermissionGranted().then(
                            (isPermissionGranted) async {
                              if (!isPermissionGranted) {
                                dontCenter = true;
                                await PermissionsService.showLocationPermissionDeniedDialog(context);
                              }
                              await PermissionsService.isLocationServicesEnabled().then(
                                (isLocationServicesEnabled) async {
                                  if (!isLocationServicesEnabled) {
                                    dontCenter = true;
                                    await PermissionsService.showLocationServiceDisabledDialog(context);
                                  }
                                },
                              );
                            },
                          );
                          if (dontCenter) return;
                          return mapboxMap?.easeTo(
                            await _getUserLocation(),
                            MapAnimationOptions(
                              duration: animationToLocationDuration,
                            ),
                          );
                        },
                      );
                    }),
              ],
            );
          },
        );
      },
    );
  }
}
