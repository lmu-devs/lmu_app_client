import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:mensa/mensa.dart';

class SearchBottomSheet extends StatelessWidget {
  final ValueNotifier<MensaModel?> selectedMensaNotifier;
  final DraggableScrollableController sheetController;

  const SearchBottomSheet({
    required this.selectedMensaNotifier,
    required this.sheetController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<MensaModel?>(
      valueListenable: selectedMensaNotifier,
      builder: (context, selectedMensa, child) {
        if (selectedMensa != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            sheetController.animateTo(
              0.3,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            sheetController.animateTo(
              0.11,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        }

        return DraggableScrollableSheet(
          controller: sheetController,
          initialChildSize: 0.11,
          minChildSize: 0.11,
          maxChildSize: 0.3,
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
                            child: MensaOverviewTile(
                              mensaModel: selectedMensa,
                              isFavorite: false,
                              hasLargeImage: false,
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
                              Icon(
                                LucideIcons.search,
                                size: LmuSizes.xlarge,
                                color: context.colors.neutralColors.textColors.weakColors.base,
                              ),
                              const SizedBox(width: LmuSizes.mediumLarge),
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
