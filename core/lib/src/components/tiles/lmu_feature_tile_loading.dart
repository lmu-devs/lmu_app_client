import 'package:core/components.dart';
import 'package:flutter/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LmuFeatureTileLoading extends StatelessWidget {
  const LmuFeatureTileLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuSkeleton(
      child: LmuFeatureTile(
        title: BoneMock.words(1),
        subtitle: BoneMock.words(2),
      ),
    );
  }
}
