import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuContentMensa extends BaseTile {
  LmuContentMensa({
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
      padding: const EdgeInsets.all(LmuSizes.size_8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: LmuSizes.size_24,
                  maxWidth: LmuSizes.size_24,
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
                    const SizedBox(height: LmuSizes.size_12),
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
                      top: LmuSizes.size_2,
                      bottom: LmuSizes.size_2,
                      left: LmuSizes.size_2 + LmuSizes.size_4,
                    ),
                    child: Row(
                      children: [
                        LmuText.bodyXSmall(
                          rating,
                          color: context.colors.neutralColors.textColors.weakColors.active,
                        ),
                        const SizedBox(width: LmuSizes.size_4),
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
                  const SizedBox(height: LmuSizes.size_4),
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
