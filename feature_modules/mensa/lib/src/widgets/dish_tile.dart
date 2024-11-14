import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mensa/src/utils/get_dish_type_emoji.dart';

import '../repository/api/models/dish_model.dart';
import '../services/dish_user_preferences_service.dart';
import 'widgets.dart';

class DishTile extends StatelessWidget {
  const DishTile({
    super.key,
    required this.dishModel,
    required this.onFavoriteTap,
    this.onTap,
  });

  final DishModel dishModel;
  final void Function()? onTap;
  final void Function()? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.neutralColors.backgroundColors.tile,
          borderRadius: BorderRadius.circular(LmuSizes.medium),
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(
          LmuSizes.mediumLarge,
        ),
        child: Stack(
          children: [
            Row(
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
                          dishModel.name,
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
                          color: context
                              .colors.neutralColors.textColors.weakColors.base,
                        ),
                        const SizedBox(width: LmuSizes.small),
                        GestureDetector(
                          onTap: onFavoriteTap,
                          child: StarIcon(isActive: dishModel.ratingModel.isLiked),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: LmuSizes.small,
                    ),
                    LmuText.bodyXSmall(
                      dishModel.priceSimple,
                      color: context
                          .colors.neutralColors.textColors.weakColors.base,
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
                    right: 0,
                    bottom: LmuSizes.mediumLarge,
                    top: LmuSizes.mediumSmall,
                    child: Container(
                      color: Colors.yellow,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          final userPreferencesService = GetIt.I.get<DishUserPreferencesService>();
                          final id = dishModel.id;
                      
                          LmuVibrations.vibrate(type: VibrationType.secondary);
                      
                          if (dishModel.ratingModel.isLiked) {
                            LmuToast.show(
                              context: context,
                              type: ToastType.success,
                              message: 'Favorit entfernt',
                              actionText: 'Rückgängig',
                              onActionPressed: () {
                                userPreferencesService.toggleFavoriteDishId(id);
                              },
                            );
                          } else {
                            LmuToast.show(
                              context: context,
                              type: ToastType.success,
                              message: 'Favorit hinzugefügt',
                            );
                          }
                      
                          userPreferencesService.toggleFavoriteDishId(id);
                        },
                        child: const SizedBox(width: 64),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
