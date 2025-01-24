import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ForYouLoadingView extends StatelessWidget {
  const ForYouLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: LmuSizes.size_24),
        LmuSkeleton(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
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
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: LmuSizes.size_16,
            vertical: LmuSizes.size_16,
          ),
          child: LmuContentTile(
            content: List.generate(
              3,
              (index) => const LmuListItemLoading(
                titleLength: 2,
                action: LmuListItemAction.toggle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
