import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/cinema.dart';
import 'package:shared_api/explore.dart';
import 'package:shared_api/mensa.dart';
import 'package:shared_api/roomfinder.dart';

import '../extensions/explore_marker_type_extension.dart';
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
    setState(() {
      _selectedLocation = _mapService.selectedMarker;
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
        return Container(
          decoration: BoxDecoration(
            color: colors.neutralColors.backgroundColors.base,
            border: Border(
              top: BorderSide(
                color: colors.neutralColors.borderColors.seperatorDark,
                width: 0.5,
              ),
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(LmuSizes.size_24),
              topRight: Radius.circular(LmuSizes.size_24),
            ),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: LmuSizes.size_24),
              BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: LmuSizes.size_64),
            ],
          ),
          child: CustomScrollView(
            controller: scrollController,
            slivers: _selectedLocation == null
                ? const [SliverToBoxAdapter(child: SizedBox.shrink())]
                : [
                    PinnedHeaderSliver(
                      child: Container(
                        padding: const EdgeInsets.all(LmuSizes.size_16),
                        decoration: BoxDecoration(
                          color: colors.neutralColors.backgroundColors.base,
                          border: Border(
                            bottom: BorderSide(
                              color: colors.neutralColors.borderColors.seperatorLight,
                              width: 0.5,
                            ),
                          ),
                        ),
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
                                    backgroundColor: _selectedLocation!.type.markerColor(colors).withOpacity(0.14),
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

      case ExploreMarkerType.roomfinderRoom:
        return GetIt.I.get<RoomfinderService>().roomfinderMapContentBuilder(context, id, controller);
    }
  }
}
