import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mensa/mensa.dart';

import 'map_bottom_sheet_sizes.dart';

class MapBottomSheet extends StatefulWidget {
  final ValueNotifier<MensaModel?> selectedMensaNotifier;
  final DraggableScrollableController sheetController;

  const MapBottomSheet({
    required this.selectedMensaNotifier,
    required this.sheetController,
    super.key,
  });

  @override
  MapBottomSheetState createState() => MapBottomSheetState();
}

class MapBottomSheetState extends State<MapBottomSheet> {
  late ValueNotifier<List<String>> _favoriteMensasNotifier;
  late TextEditingController _searchController;
  late DraggableScrollableController _sheetController;
  double _previousSize = SheetSizes.small.size;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _favoriteMensasNotifier = GetIt.I.get<MensaUserPreferencesService>().favoriteMensaIdsNotifier;
    _searchController = TextEditingController();
    _sheetController = widget.sheetController;
    _sheetController.addListener(_onSheetScroll);

    _fadeController = AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 250),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _sheetController.removeListener(_onSheetScroll);
    _fadeController.dispose();
    super.dispose();
  }

  void _onSheetScroll() {
    if (_previousSize >= SheetSizes.medium.size && _sheetController.size < SheetSizes.medium.size) {
      if (widget.selectedMensaNotifier.value != null) {
        widget.selectedMensaNotifier.value = null;
      }
    }
    _previousSize = _sheetController.size;
  }

  void _animateSheet(MensaModel? selectedMensa) {
    if (selectedMensa != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _sheetController.animateTo(
          SheetSizes.medium.size,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      });
      _fadeController.forward();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _sheetController.animateTo(
          SheetSizes.small.size,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
      _fadeController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<MensaModel?>(
      valueListenable: widget.selectedMensaNotifier,
      builder: (context, selectedMensa, child) {
        List<double> snapSizes = selectedMensa != null
            ? [SheetSizes.medium.size, SheetSizes.large.size]
            : [SheetSizes.small.size, SheetSizes.medium.size, SheetSizes.large.size];

        _animateSheet(selectedMensa);

        if (selectedMensa != null) {
          _searchController.text = selectedMensa.name;
        } else {
          _searchController.text = '';
        }

        return DraggableScrollableSheet(
          controller: _sheetController,
          initialChildSize: SheetSizes.small.size,
          minChildSize: SheetSizes.small.size,
          maxChildSize: SheetSizes.large.size,
          snap: true,
          snapSizes: snapSizes,
          snapAnimationDuration: const Duration(milliseconds: 250),
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(LmuSizes.mediumLarge),
              decoration: BoxDecoration(
                color: context.colors.neutralColors.backgroundColors.base,
                border: Border(
                  top: BorderSide(
                    color: context.colors.neutralColors.backgroundColors.strongColors.base,
                  ),
                ),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    if (selectedMensa != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: LmuSizes.small),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: ValueListenableBuilder<List<String>>(
                            valueListenable: _favoriteMensasNotifier,
                            builder: (context, favoriteMensas, _) {
                              return MensaOverviewTile(
                                mensaModel: selectedMensa,
                                isFavorite: favoriteMensas.contains(selectedMensa.canteenId),
                                hasLargeImage: false,
                                hasButton: true,
                                buttonText: context.locals.explore.navigate,
                                buttonAction: () => LmuBottomSheet.show(
                                  context,
                                  content: NavigationSheet(
                                    latitude: selectedMensa.location.latitude,
                                    longitude: selectedMensa.location.longitude,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                    LmuSearchInputField(
                      context: context,
                      controller: _searchController,
                      onClearPressed: () {
                        _searchController.clear();
                        widget.selectedMensaNotifier.value = null;
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}