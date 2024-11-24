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
    final localizations = context.locals.app;
    return Padding(
      padding: EdgeInsets.only(bottom: hasDivider ? LmuSizes.none : LmuSizes.medium),
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
                    LmuText.body(
                      getDishTypeEmoji(menuItemModel.dishType),
                    ),
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
                              child: Flexible(
                                child: Row(
                                  children: excludedLabelItemsName!
                                      .mapIndexed(
                                        (index, name) => Padding(
                                          padding: EdgeInsets.only(
                                            right: index == excludedLabelItemsName!.length - 1 ? 0 : LmuSizes.small,
                                          ),
                                          child: LmuInTextVisual.text(
                                            title: name,
                                            destructive: true,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: LmuSizes.medium,
                    ),
                    LmuText.bodyXSmall(
                      menuItemModel.ratingModel.likeCount.toString(),
                      color: context.colors.neutralColors.textColors.weakColors.base,
                    ),
                    const SizedBox(width: LmuSizes.small),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StarIcon(isActive: isFavorite),
                        const SizedBox(
                          height: LmuSizes.small,
                        ),
                        LmuText.bodyXSmall(
                          menuItemModel.priceSimple,
                          color: context.colors.neutralColors.textColors.weakColors.base,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                bottom: LmuSizes.mediumLarge,
                top: LmuSizes.mediumSmall,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    final userPreferencesService = GetIt.I.get<MensaUserPreferencesService>();
                    final id = menuItemModel.id;

                    LmuVibrations.vibrate(type: VibrationType.secondary);

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
                  },
                  child: const SizedBox(width: 64),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
