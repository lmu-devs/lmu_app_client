import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../repository/api/models/menu/menu_item_model.dart';
import '../../../services/mensa_user_preferences_service.dart';
import '../../../utils/get_dish_type_emoji.dart';
import '../../widgets.dart';

class MenuItemTile extends StatelessWidget {
  const MenuItemTile({
    super.key,
    required this.menuItemModel,
    required this.isFavorite,
    this.hasDivider = false,
    this.excludedLabelItemsName,
    this.onTap,
  });

  final MenuItemModel menuItemModel;
  final void Function()? onTap;
  final bool hasDivider;
  final bool isFavorite;
  final List<String>? excludedLabelItemsName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: hasDivider ? LmuSizes.medium : LmuSizes.none),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: context.colors.neutralColors.backgroundColors.tile,
            borderRadius: BorderRadius.circular(LmuSizes.medium),
          ),
          width: double.infinity,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(LmuSizes.mediumLarge),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LmuText.h3(getDishTypeEmoji(menuItemModel.dishType)),
                    const SizedBox(width: LmuSizes.medium),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: LmuText.body(
                                  menuItemModel.title,
                                ),
                              ),
                            ],
                          ),
                          if (excludedLabelItemsName != null && excludedLabelItemsName!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: LmuSizes.mediumSmall),
                              child: Wrap(
                                spacing: LmuSizes.small,
                                runSpacing: LmuSizes.small,
                                children: excludedLabelItemsName!.mapIndexed(
                                  (index, name) {
                                    return LmuInTextVisual.text(
                                      title: name,
                                      destructive: true,
                                    );
                                  },
                                ).toList(),
                              ),
                            )
                        ],
                      ),
                    ),
                    const SizedBox(width: LmuSizes.medium),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _toggleDishFavorite(context),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: LmuSizes.xsmall),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                LmuText.bodyXSmall(
                                  menuItemModel.ratingModel.likeCount == -1
                                      ? ""
                                      : menuItemModel.ratingModel.likeCount.toString(),
                                  color: context.colors.neutralColors.textColors.weakColors.base,
                                ),
                                const SizedBox(width: LmuSizes.small),
                                StarIcon(isActive: isFavorite),
                              ],
                            ),
                          ),
                          const SizedBox(height: LmuSizes.small),
                          ConstrainedBox(
                            constraints: const BoxConstraints(minWidth: LmuSizes.large),
                            child: Center(
                              child: LmuText.bodyXSmall(
                                menuItemModel.priceSimple,
                                color: context.colors.neutralColors.textColors.weakColors.base,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleDishFavorite(BuildContext context) {
    final localizations = context.locals.app;
    final userPreferencesService = GetIt.I.get<MensaUserPreferencesService>();
    final id = menuItemModel.id;

    LmuVibrations.secondary();

    if (isFavorite) {
      LmuToast.show(
        context: context,
        type: ToastType.success,
        message: localizations.favoriteRemoved,
        actionText: localizations.undo,
        onActionPressed: () {
          userPreferencesService.toggleFavoriteDishId(id.toString());
        },
      );
    } else {
      LmuToast.show(
        context: context,
        type: ToastType.success,
        message: localizations.favoriteAdded,
      );
    }

    userPreferencesService.toggleFavoriteDishId(id.toString());
  }
}
