import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/explore.dart';

import '../../extensions/sort_option_sort_extension.dart';
import '../../repository/api/models/mensa/mensa_model.dart';
import '../../repository/api/models/user_preferences/sort_option.dart';
import '../../services/mensa_user_preferences_service.dart';

class MensaOverviewButtonSection extends StatelessWidget {
  const MensaOverviewButtonSection({
    super.key,
    required this.sortOptionNotifier,
    required this.isOpenNowFilerNotifier,
    required this.sortedMensaModelsNotifier,
    required this.mensaModels,
  });

  final ValueNotifier<SortOption> sortOptionNotifier;
  final ValueNotifier<bool> isOpenNowFilerNotifier;
  final ValueNotifier<List<MensaModel>> sortedMensaModelsNotifier;
  final List<MensaModel> mensaModels;

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.canteen;
    return Row(
      children: [
        GestureDetector(
          onTap: () => GetIt.I.get<ExploreService>().navigateToExplore(context),
          child: Container(
            height: LmuActionSizes.base,
            width: LmuActionSizes.base,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LmuRadiusSizes.medium),
              image: const DecorationImage(
                image:
                    AssetImage("assets/maps_icon_dark.png", package: "mensa"),
              ),
            ),
          ),
        ),
        const SizedBox(width: LmuSizes.mediumSmall),
        ValueListenableBuilder(
          valueListenable: sortOptionNotifier,
          builder: (context, activeSortOption, _) {
            return LmuButton(
              title: SortOption.values
                  .firstWhere((option) => option == activeSortOption)
                  .title(localizations),
              emphasis: ButtonEmphasis.secondary,
              trailingIcon: LucideIcons.chevron_down,
              onTap: () => _showSortOptionActionSheet(context),
            );
          },
        ),
        const SizedBox(width: LmuSizes.mediumSmall),
        ValueListenableBuilder(
          valueListenable: isOpenNowFilerNotifier,
          builder: (context, isOpenNowFilterActive, _) {
            return LmuButton(
              title: localizations.openNow,
              emphasis: isOpenNowFilterActive
                  ? ButtonEmphasis.primary
                  : ButtonEmphasis.secondary,
              onTap: () =>
                  isOpenNowFilerNotifier.value = !isOpenNowFilerNotifier.value,
            );
          },
        )
      ],
    );
  }

  void _showSortOptionActionSheet(BuildContext context) {
    LmuBottomSheet.show(
      context,
      content: _SortOptionActionSheetContent(
        sortOptionNotifier: sortOptionNotifier,
        sortedMensaModelsNotifier: sortedMensaModelsNotifier,
        mensaModels: mensaModels,
      ),
    );
  }
}

class _SortOptionActionSheetContent extends StatelessWidget {
  const _SortOptionActionSheetContent({
    required this.sortOptionNotifier,
    required this.sortedMensaModelsNotifier,
    required this.mensaModels,
  });

  final ValueNotifier<SortOption> sortOptionNotifier;
  final ValueNotifier<List<MensaModel>> sortedMensaModelsNotifier;
  final List<MensaModel> mensaModels;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: sortOptionNotifier,
      builder: (context, activeValue, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...SortOption.values.map(
              (sortOption) {
                final isActive = sortOption == activeValue;

                final textColor = activeValue.textColor(
                  context.colors,
                  isActive: isActive,
                );

                return Column(
                  children: [
                    LmuListItem.base(
                      title: sortOption == activeValue
                          ? sortOption.title(context.locals.canteen)
                          : null,
                      titleColor: textColor,
                      subtitle: sortOption == activeValue
                          ? null
                          : sortOption.title(context.locals.canteen),
                      mainContentAlignment: MainContentAlignment.center,
                      leadingArea: LmuIcon(
                        icon: sortOption.icon,
                        size: LmuIconSizes.medium,
                        color: textColor,
                      ),
                      onTap: () async {
                        sortOptionNotifier.value = sortOption;
                        sortedMensaModelsNotifier.value =
                            sortOption.sort(mensaModels);
                        await GetIt.I
                            .get<MensaUserPreferencesService>()
                            .updateSortOption(sortOption);
                        Future.delayed(
                          const Duration(milliseconds: 100),
                          () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                        );
                      },
                    ),
                    if (sortOption != SortOption.values.last)
                      const SizedBox(
                        height: LmuSizes.mediumSmall,
                      ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}

extension SortOptionExtension on SortOption {
  IconData get icon {
    switch (this) {
      case SortOption.alphabetically:
        return LucideIcons.arrow_down_a_z;
      case SortOption.distance:
        return LucideIcons.arrow_down_0_1;
      case SortOption.rating:
        return LucideIcons.arrow_down_1_0;
      case SortOption.type:
        return LucideIcons.arrow_down_1_0;
    }
  }

  String title(CanteenLocalizations localizations) {
    switch (this) {
      case SortOption.alphabetically:
        return localizations.alphabetically;
      case SortOption.distance:
        return localizations.distance;
      case SortOption.rating:
        return localizations.rating;
      case SortOption.type:
        return localizations.type;
    }
  }

  Color textColor(
    LmuColors colors, {
    required bool isActive,
  }) {
    if (isActive) {
      return colors.brandColors.textColors.strongColors.base;
    }
    return colors.neutralColors.textColors.mediumColors.base;
  }
}
