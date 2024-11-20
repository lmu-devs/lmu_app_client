import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../repository/api/models/menu/menu_item_model.dart';
import '../services/mensa_user_preferences_service.dart';
import '../utils/get_dish_type_emoji.dart';
import 'widgets.dart';

class DishTile extends StatelessWidget {
  const DishTile({
    super.key,
    required this.dishModel,
    required this.onFavoriteTap,
    required this.isFavorite,
    this.onTap,
  });

  final MenuItemModel dishModel;
  final void Function()? onTap;
  final void Function()? onFavoriteTap;
  final bool isFavorite;
  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.app;
    return GestureDetector(
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
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LmuText.body(
                          getDishTypeEmoji(dishModel.dishType),
                        ),
                        const SizedBox(
                          width: LmuSizes.medium,
                        ),
                        Flexible(
                          child: LmuText.body(
                            dishModel.title,
                            weight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: LmuSizes.xlarge,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          LmuText.bodyXSmall(
                            dishModel.ratingModel.likeCount.toString(),
                            color: context.colors.neutralColors.textColors.weakColors.base,
                          ),
                          const SizedBox(width: LmuSizes.small),
                          StarIcon(isActive: isFavorite),
                        ],
                      ),
                      const SizedBox(
                        height: LmuSizes.small,
                      ),
                      LmuText.bodyXSmall(
                        dishModel.priceSimple,
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
                  final id = dishModel.id;

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
    );
  }
}
