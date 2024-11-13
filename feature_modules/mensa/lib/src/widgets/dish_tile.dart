import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:mensa/src/utils/get_dish_type_emoji.dart';

import 'widgets.dart';

class DishTile extends StatelessWidget {
  const DishTile({
    super.key,
    required this.dishType,
    required this.title,
    required this.priceSimple,
    required this.isLiked,
    required this.likeCount,
    required this.onFavoriteTap,
    this.onTap,
  });

  final String dishType;
  final String title;
  final String priceSimple;
  final void Function()? onTap;
  final bool isLiked;
  final int likeCount;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LmuText.body(
                        getDishTypeEmoji(dishType),
                      ),
                      const SizedBox(
                        width: LmuSizes.medium,
                      ),
                      Flexible(
                        child: LmuText.body(
                          title,
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
                        LmuText.bodySmall(likeCount.toString()),
                        const SizedBox(width: LmuSizes.small),
                        GestureDetector(
                          onTap: onFavoriteTap,
                          child: StarIcon(isActive: isLiked),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: LmuSizes.small,
                    ),
                    LmuText.bodySmall(
                      priceSimple,
                      weight: FontWeight.w300,
                    ),
                  ],
                ),
              ],
            ),

            /// Add Allergens
          ],
        ),
      ),
    );
  }
}
