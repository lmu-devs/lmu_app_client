import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class ExploreMapSearchSheetContent extends StatelessWidget {
  const ExploreMapSearchSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      children: [
        LmuTileHeadline.base(title: "Favorites"),
        LmuContentTile(
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_12),
            child: SizedBox(
              height: 94,
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(width: 20),
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  final isFirst = index == 0;
                  final isLast = index == 5;
                  return Padding(
                    padding: EdgeInsets.only(
                      left: isFirst ? 12 : 0,
                      right: isLast ? 12 : 0,
                    ),
                    child: SizedBox(
                      width: 48,
                      child: Column(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: colors.mensaColors.textColors.mensa,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: context.colors.neutralColors.borderColors.iconOutline,
                                width: 2,
                              ),
                            ),
                            child: LmuIcon(
                              icon: LucideIcons.utensils,
                              size: 24,
                              color: context.colors.neutralColors.textColors.flippedColors.base,
                            ),
                          ),
                          const SizedBox(height: 6),
                          LmuText.bodyXSmall(
                            "Leopold",
                            customOverFlow: TextOverflow.ellipsis,
                            color: colors.neutralColors.textColors.strongColors.base,
                          ),
                          LmuText.bodyXSmall(
                            "200 m",
                            customOverFlow: TextOverflow.ellipsis,
                            color: colors.neutralColors.textColors.mediumColors.base,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
