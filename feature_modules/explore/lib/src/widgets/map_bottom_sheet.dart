import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mensa/mensa.dart';
import 'map_bottom_sheet_sizes.dart';
import 'package:core/widgets.dart';

class MapBottomSheet extends StatelessWidget {
  final ValueNotifier<MensaModel?> selectedMensaNotifier;
  final DraggableScrollableController sheetController;
  final TextEditingController _searchController = TextEditingController();

  MapBottomSheet({
    required this.selectedMensaNotifier,
    required this.sheetController,
    super.key,
  });

  final ValueNotifier<List<String>> favoriteMensasNotifier =
      GetIt.I.get<MensaUserPreferencesService>().favoriteMensaIdsNotifier;

  void _animateSheet(MensaModel? selectedMensa) {
    if (selectedMensa != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        sheetController.animateTo(
          SheetSizes.medium.size,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        sheetController.animateTo(
          SheetSizes.small.size,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<MensaModel?>(
      valueListenable: selectedMensaNotifier,
      builder: (context, selectedMensa, child) {
        _animateSheet(selectedMensa);

        if (selectedMensa != null) {
          _searchController.text = selectedMensa.name;
        } else {
          _searchController.text = '';
        }

        return DraggableScrollableSheet(
          controller: sheetController,
          initialChildSize: SheetSizes.small.size,
          minChildSize: SheetSizes.small.size,
          maxChildSize: SheetSizes.medium.size,
          builder: (context, scrollController) {
            return Container(
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
                child: Padding(
                  padding: const EdgeInsets.all(LmuSizes.mediumLarge),
                  child: Column(
                    children: [
                      selectedMensa != null
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: LmuSizes.small),
                              child: ValueListenableBuilder<List<String>>(
                                valueListenable: favoriteMensasNotifier,
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
                            )
                          : const SizedBox.shrink(),
                      const SizedBox(height: LmuSizes.small),
                      LmuSearchInputField(
                        context: context,
                        controller: _searchController,
                        searchState: selectedMensa != null 
                            ? SearchState.filled 
                            : SearchState.base,
                        onClearPressed: () {
                          _searchController.clear();
                          selectedMensaNotifier.value = null;
                        },
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
