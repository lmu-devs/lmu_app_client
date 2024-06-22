import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import 'base_tile.dart';

class LmuContentTile extends BaseTile {
  LmuContentTile({
    required this.inTextVisuals,
    super.key,
  });

  final String symbol = "🥕";
  final String title = "Mexikanischer Reistopf mit Bohnen, Paprika und Mais";
  final List<LmuInTextVisual> inTextVisuals;
  final String rating = "10K";
  final String price = "€€€";
  final bool isFavorite = true;
  final VoidCallback onFavoriteTap = () {};

  @override
  Widget buildTile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(LmuSizes.mediumSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: LmuSizes.xlarge,
                  maxWidth: LmuSizes.xlarge,
                ),
                child: LmuText.body(symbol),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LmuText.body(
                      title,
                    ),
                    const SizedBox(height: LmuSizes.medium),
                    LmuPaddedInTextVisuals(
                      noPaddingOnFirstElement: true,
                      inTextVisuals: inTextVisuals,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: LmuSizes.xsmall,
                      bottom: LmuSizes.xsmall,
                      left: LmuSizes.xsmall + LmuSizes.small,
                    ),
                    child: Row(
                      children: [
                        LmuText.bodyXSmall(
                          rating,
                          color: context.colors.neutralColors.textColors.weakColors.active,
                        ),
                        const SizedBox(width: LmuSizes.small),
                        GestureDetector(
                          onTap: onFavoriteTap,
                          child: isFavorite
                              ? const LmuIcon(
                                  icon: Icons.star,
                                  size: 20,
                                  color: Color.fromARGB(255, 247, 209, 21),
                                )
                              : LmuIcon(
                                  icon: Icons.star_border_outlined,
                                  size: LmuIconSizes.medium,
                                  color: context.colors.neutralColors.backgroundColors.flippedColors.base,
                                ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: LmuSizes.small),
                  LmuText.bodyXSmall(
                    price,
                    color: context.colors.neutralColors.textColors.weakColors.active,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
