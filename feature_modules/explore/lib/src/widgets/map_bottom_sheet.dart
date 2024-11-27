import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:mensa/mensa.dart';
import 'map_bottom_sheet_sizes.dart';
import 'package:core/widgets.dart';

class MapBottomSheet extends StatelessWidget {
  final ValueNotifier<MensaModel?> selectedMensaNotifier;
  final DraggableScrollableController sheetController;

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
          curve: Curves.easeIn,
        );
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        sheetController.animateTo(
          SheetSizes.small.size,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
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

        return DraggableScrollableSheet(
          controller: sheetController,
          initialChildSize: SheetSizes.small.size,
          minChildSize: SheetSizes.small.size,
          maxChildSize: SheetSizes.large.size,
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: LmuSizes.medium,
                        horizontal: LmuSizes.mediumLarge,
                      ),
                      decoration: BoxDecoration(
                        color: context.colors.neutralColors.backgroundColors.tile,
                        borderRadius: const BorderRadius.all(Radius.circular(LmuRadiusSizes.medium)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              selectedMensa?.name == null
                                  ? Padding(
                                      padding: const EdgeInsets.only(right: LmuSizes.mediumLarge),
                                      child: Icon(
                                        LucideIcons.search,
                                        size: LmuSizes.xlarge,
                                        color: context.colors.neutralColors.textColors.weakColors.base,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              LmuText.bodySmall(selectedMensa?.name ?? context.locals.app.search),
                            ],
                          ),
                          selectedMensa != null
                              ? GestureDetector(
                                  onTap: () => selectedMensaNotifier.value = null,
                                  child: Icon(
                                    LucideIcons.x,
                                    size: LmuSizes.xlarge,
                                    color: context.colors.neutralColors.textColors.strongColors.base,
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
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
