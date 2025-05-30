import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class SportsLoadingView extends StatelessWidget {
  const SportsLoadingView({super.key});

  final loadingTileCount = const [6, 4, 2, 3];
  @override
  Widget build(BuildContext context) {
    final starColor = context.colors.neutralColors.textColors.weakColors.base;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LmuListItemLoading(
                  leadingArea: Center(child: LmuText.body("🎟️")),
                  subtitleLength: 5,
                  hasHorizontalPadding: false,
                  hasDivier: true,
                ),
                LmuListItemLoading(
                  leadingArea: Center(child: LmuText.body("🥇")),
                  subtitleLength: 4,
                  hasHorizontalPadding: false,
                  hasDivier: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: LmuSizes.size_16),
          Padding(
            padding: const EdgeInsets.all(LmuSizes.size_16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: LmuSizes.size_24,
                  child: StarIcon(isActive: false, size: LmuIconSizes.small, disabledColor: starColor),
                ),
                const SizedBox(height: LmuSizes.size_12),
                LmuContentTile(
                  contentList: List.generate(
                    2,
                    (index) => const LmuListItemLoading(
                      leadingArea: LmuStatusDot(),
                      titleLength: 2,
                      trailingTitleLength: 1,
                      action: LmuListItemAction.chevron,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: LmuSizes.size_16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
                child: LmuTileHeadlineLoading(titleLength: 2),
              ),
              LmuButtonRow(
                buttons: [
                  LmuIconButton(
                    icon: LucideIcons.search,
                    isDisabled: true,
                    onPressed: () {},
                  ),
                  LmuButton(
                    title: context.locals.app.available,
                    emphasis: ButtonEmphasis.secondary,
                    state: ButtonState.disabled,
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(LmuSizes.size_16),
            child: Column(
              children: List.generate(
                loadingTileCount.length,
                (index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LmuTileHeadlineLoading(titleLength: 1),
                    LmuContentTile(
                      contentList: List.generate(
                        loadingTileCount[index],
                        (index) => const LmuListItemLoading(
                          leadingArea: LmuStatusDot(),
                          titleLength: 2,
                          trailingTitleLength: 1,
                          action: LmuListItemAction.chevron,
                        ),
                      ),
                    ),
                    const SizedBox(height: LmuSizes.size_32),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: LmuSizes.size_64)
        ],
      ),
    );
  }
}
