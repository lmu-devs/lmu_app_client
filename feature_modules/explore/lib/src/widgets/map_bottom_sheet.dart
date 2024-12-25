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
  late DraggableScrollableController _sheetController;
  double _previousSize = SheetSizes.small.size;

  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _favoriteMensasNotifier = GetIt.I.get<MensaUserPreferencesService>().favoriteMensaIdsNotifier;

    _sheetController = widget.sheetController;
    _sheetController.addListener(_onSheetScroll);

    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    _searchFocusNode.addListener(_onSearchFocusChange);

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
    _searchFocusNode.removeListener(_onSearchFocusChange);
    _searchFocusNode.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _onSheetScroll() {
    if (double.parse(_previousSize.toStringAsFixed(2)) >= SheetSizes.medium.size &&
        double.parse(_sheetController.size.toStringAsFixed(2)) < SheetSizes.medium.size) {
      if (widget.selectedMensaNotifier.value != null) {
        widget.selectedMensaNotifier.value = null;
      }
    }
    _previousSize = _sheetController.size;
  }

  void _onSearchFocusChange() {
    if (_searchFocusNode.hasFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _sheetController.animateTo(
          SheetSizes.large.size,
          duration: const Duration(milliseconds: 300),
          curve: LmuAnimations.fastSmooth,
        );
      });
    }
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
              decoration: BoxDecoration(
                color: context.colors.neutralColors.backgroundColors.base,
                border: Border(
                  top: BorderSide(
                    color: context.colors.neutralColors.borderColors.seperatorDark,
                    width: 0.5,
                  ),
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(LmuSizes.size_24),
                  topRight: Radius.circular(LmuSizes.size_24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 24,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 64,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(LmuSizes.size_16),
                  child: Column(
                    children: [
                      if (selectedMensa != null)
                        FadeTransition(
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
                                    address: selectedMensa.location.address,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      else
                        const SizedBox.shrink(),
                      LmuSearchInputField(
                        context: context,
                        controller: _searchController,
                        focusNode: _searchFocusNode,
                        focusAfterClear: false,
                        onClearPressed: () {
                          _searchController.clear();
                          widget.selectedMensaNotifier.value = null;
                        },
                        isLoading: false,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
