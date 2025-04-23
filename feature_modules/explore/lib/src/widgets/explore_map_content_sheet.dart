import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/explore.dart';

import '../extensions/explore_marker_type_extension.dart';
import '../routes/explore_routes.dart';
import '../services/explore_map_service.dart';

class ExploreMapContentSheet extends StatefulWidget {
  const ExploreMapContentSheet({
    super.key,
    required this.sheetController,
  });

  final DraggableScrollableController sheetController;

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
    _baseSize = 0.27;
    _maxSize = 0.9;

    _sheetController = widget.sheetController;
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
      final titleLength = _selectedLocation!.name.length;
      if (titleLength >= 24) {
        _resize();
        return;
      }
      if (!_isOpen || _isExpanded) {
        _open();
      }
    } else {
      _close();
    }
  }

  void _resize() {
    _sheetController
        .animateTo(
      _baseSize + 0.115,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    )
        .then((_) {
      _isOpen = true;
      _isExpanded = true;
    });
  }

  void _open() {
    _sheetController
        .animateTo(
      _baseSize,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    )
        .then((_) {
      _isOpen = true;
      _isExpanded = false;
    });
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
    final locals = context.locals;
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
          child: SingleChildScrollView(
            controller: scrollController,
            physics: const ClampingScrollPhysics(),
            child: _selectedLocation == null
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.all(LmuSizes.size_16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Wrap(
                                spacing: 8,
                                runSpacing: 8,
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
                            GestureDetector(
                              onTap: () {
                                _close();
                                _mapService.deselectMarker();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(LmuSizes.size_4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: colors.neutralColors.backgroundColors.mediumColors.base,
                                ),
                                child: const /*  */ LmuIcon(
                                  icon: LucideIcons.x,
                                  size: LmuIconSizes.medium,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: LmuSizes.size_16),
                        LmuListItem.base(
                          subtitle: _selectedLocation!.address,
                          trailingArea: Icon(
                            LucideIcons.map,
                            size: LmuIconSizes.mediumSmall,
                            color: context.colors.neutralColors.textColors.weakColors.base,
                          ),
                          hasHorizontalPadding: false,
                          hasDivider: true,
                          onTap: () {
                            LmuBottomSheet.show(
                              context,
                              content: NavigationSheet(
                                latitude: _selectedLocation!.latitude,
                                longitude: _selectedLocation!.longitude,
                                address: _selectedLocation!.address,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: LmuSizes.size_16),
                        LmuContentTile(
                          content: LmuListItem.action(
                            title: "${locals.explore.show} ${_selectedLocation!.type.localizedName(locals)}",
                            actionType: LmuListItemAction.chevron,
                            onTap: () {
                              if (_selectedLocation != null) {
                                final id = _selectedLocation!.id;
                                final exploreType = _selectedLocation!.type;
                                switch (exploreType) {
                                  case ExploreMarkerType.mensaMensa:
                                  case ExploreMarkerType.mensaStuBistro:
                                  case ExploreMarkerType.mensaStuCafe:
                                  case ExploreMarkerType.mensaStuLounge:
                                    ExploreMensaRoute(id).go(context);
                                    break;
                                  case ExploreMarkerType.cinema:
                                    ExploreCinemaRoute(id).go(context);
                                    break;
                                  case ExploreMarkerType.roomfinderRoom:
                                    ExploreBuildingRoute(id).go(context);
                                    break;
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
