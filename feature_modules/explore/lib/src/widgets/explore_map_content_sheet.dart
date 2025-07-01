import 'dart:ui';

import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/cinema.dart';
import 'package:shared_api/explore.dart';
import 'package:shared_api/libraries.dart';
import 'package:shared_api/mensa.dart';
import 'package:shared_api/roomfinder.dart';

import '../extensions/explore_marker_type_extension.dart';
import '../services/explore_location_service.dart';
import '../services/explore_map_service.dart';

class ExploreMapContentSheet extends StatefulWidget {
  const ExploreMapContentSheet({super.key});

  @override
  ExploreMapContentSheetState createState() => ExploreMapContentSheetState();
}

class ExploreMapContentSheetState extends State<ExploreMapContentSheet> {
  late DraggableScrollableController _sheetController;
  bool _isOpen = false;
  bool _isExpanded = false;
  late final double _minSize;
  double _baseSize = 0;
  late final double _maxSize;

  ExploreLocation? _selectedLocation;

  final _mapService = GetIt.I<ExploreMapService>();
  final _locationService = GetIt.I<ExploreLocationService>();

  @override
  void initState() {
    super.initState();

    _minSize = 0;
    _baseSize = 0.40;
    _maxSize = 0.9;

    _sheetController = DraggableScrollableController();
    _sheetController.addListener(_onScroll);

    _mapService.selectedMarkerNotifier.addListener(_onMarkerSelection);
  }

  @override
  void dispose() {
    _sheetController.dispose();
    _mapService.selectedMarkerNotifier.removeListener(_onMarkerSelection);
    super.dispose();
  }

  void _onScroll() {
    if (_sheetController.size < _minSize + 0.01 && _isOpen) {
      _mapService.deselectMarker();
    }
  }

  void _onMarkerSelection() {
    final selectedMarkerId = _mapService.selectedMarkerNotifier.value;

    setState(() {
      _selectedLocation = selectedMarkerId == null ? null : _locationService.getLocationById(selectedMarkerId);
    });

    if (_selectedLocation != null) {
      if (!_isOpen || _isExpanded) {
        _open();
      }
    } else {
      _close();
    }
  }

  void _open() {
    _sheetController.animateTo(_baseSize, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut).then(
      (_) {
        _isOpen = true;
        _isExpanded = false;
      },
    );
  }

  void _close() {
    if (!_isOpen) return;

    _sheetController
        .animateTo(
      _minSize,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    )
        .then((_) {
      _isOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return DraggableScrollableSheet(
      controller: _sheetController,
      initialChildSize: _minSize,
      minChildSize: _minSize,
      maxChildSize: _maxSize,
      snapSizes: [_minSize, _baseSize],
      snap: true,
      snapAnimationDuration: const Duration(milliseconds: 150),
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(LmuSizes.size_24),
            topRight: Radius.circular(LmuSizes.size_24),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: colors.neutralColors.backgroundColors.base,
              border: Border(
                top: BorderSide(
                  color: colors.neutralColors.borderColors.seperatorDark,
                  width: 0.5,
                ),
              ),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.10), blurRadius: LmuSizes.size_24),
                BoxShadow(color: Colors.black.withValues(alpha: 0.10), blurRadius: LmuSizes.size_64),
              ],
            ),
            child: CustomScrollView(
              controller: scrollController,
              slivers: _selectedLocation == null
                  ? []
                  : [
                      PinnedHeaderSliver(
                        child: ListenableBuilder(
                          listenable: scrollController,
                          builder: (context, child) {
                            final scrollOffset = scrollController.hasClients ? scrollController.offset : 0.0;
                            final borderOpacity = clampDouble(scrollOffset, 0, LmuSizes.size_16);
                            return Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(LmuSizes.size_16),
                                  decoration: BoxDecoration(
                                    color: colors.neutralColors.backgroundColors.base,
                                  ),
                                  child: child,
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Opacity(
                                    opacity: borderOpacity / LmuSizes.size_16,
                                    child: const LmuDivider(),
                                  ),
                                ),
                              ],
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Wrap(
                                  spacing: LmuSizes.size_8,
                                  runSpacing: LmuSizes.size_8,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    LmuText.h1(_selectedLocation!.name),
                                    LmuInTextVisual.text(
                                      title: _selectedLocation!.type.localizedName(context.locals),
                                      textColor: _selectedLocation!.type.markerColor(colors),
                                      backgroundColor:
                                          _selectedLocation!.type.markerColor(colors).withValues(alpha: 0.14),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: LmuSizes.size_16),
                              GestureDetector(
                                onTap: () {
                                  _close();
                                  _mapService.deselectMarker();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_2),
                                  child: Container(
                                    padding: const EdgeInsets.all(LmuSizes.size_4),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: colors.neutralColors.backgroundColors.mediumColors.base,
                                    ),
                                    child: const LmuIcon(
                                      icon: LucideIcons.x,
                                      size: LmuIconSizes.medium,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ..._selectedLocation!.type.getContent(context, _selectedLocation!.id, scrollController),
                    ],
            ),
          ),
        );
      },
    );
  }
}

extension on ExploreMarkerType {
  List<Widget> getContent(BuildContext context, String id, ScrollController controller) {
    switch (this) {
      case ExploreMarkerType.mensaMensa:
      case ExploreMarkerType.mensaStuBistro:
      case ExploreMarkerType.mensaStuCafe:
      case ExploreMarkerType.mensaStuLounge:
        return GetIt.I.get<MensaService>().mensaMapContentBuilder(context, id, controller);
      case ExploreMarkerType.cinema:
        return GetIt.I.get<CinemaService>().cinemaMapContentBuilder(context, id, controller);
      case ExploreMarkerType.roomfinderBuilding:
        return GetIt.I.get<RoomfinderService>().roomfinderMapContentBuilder(context, id, controller);
      case ExploreMarkerType.library:
        return GetIt.I.get<LibrariesService>().librariesMapContentBuilder(context, id, controller);
    }
  }
}
