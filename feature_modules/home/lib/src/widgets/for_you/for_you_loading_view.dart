import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ForYouLoadingView extends StatelessWidget {
  const ForYouLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: LmuSizes.size_16),
          LmuSkeleton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                4,
                (index) => LmuButton(
                  title: BoneMock.words(1),
                  emphasis: ButtonEmphasis.secondary,
                  state: ButtonState.disabled,
                ),
              ),
            ),
          ),
          const SizedBox(height: LmuSizes.size_24),
          LmuContentTile(
            content: List.generate(
              1,
              (index) => const LmuListItemLoading(
                titleLength: 3,
                action: LmuListItemAction.checkbox,
              ),
            ),
          ),
          const SizedBox(height: LmuSizes.size_32),
          const LmuTileHeadlineLoading(),
          LmuContentTile(
            content: List.generate(
              2,
              (index) => const LmuListItemLoading(
                titleLength: 3,
                trailingSubtitleLength: 2,
              ),
            ),
          ),
          const SizedBox(height: LmuSizes.size_32),
          const LmuTileHeadlineLoading(),
        ],
      ),
    );
  }
}
