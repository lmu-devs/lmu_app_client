import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class DishTile extends StatelessWidget {
  const DishTile({
    super.key,
    required this.title,
    required this.priceSimple,
    required this.isFavorite,
    required this.onFavoriteTap,
    this.onTap,
  });

  final String title;
  final String priceSimple;
  final void Function()? onTap;
  final bool isFavorite;
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: LmuText.body(
                title,
                weight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              width: LmuSizes.medium,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: onFavoriteTap,
                  child: isFavorite
                      ? LmuIcon(
                          icon: Icons.star,
                          size: LmuIconSizes.medium,
                          color: context.colors.warningColors.textColors.strongColors.base,
                        )
                      : LmuIcon(
                          icon: Icons.star_border_outlined,
                          size: LmuIconSizes.medium,
                          color: context.colors.neutralColors.backgroundColors.flippedColors.base,
                        ),
                ),
                LmuText.bodySmall(
                  priceSimple,
                  weight: FontWeight.w300,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
