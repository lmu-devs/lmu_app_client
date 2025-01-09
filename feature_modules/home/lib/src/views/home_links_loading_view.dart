import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeLinksLoadingView extends StatelessWidget {
  const HomeLinksLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuSkeleton(
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
    );
  }
}
