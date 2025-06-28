import 'package:flutter/material.dart';

import '../../../themes.dart';
import '../../constants/lmu_icon_sizes.dart';

enum ProgressIndicatorColor {
  weak,
  strong,
}

enum ProgressIndicatorSize {
  small,
  medium,
  large,
}

class LmuProgressIndicator extends StatelessWidget {
  const LmuProgressIndicator({
    super.key,
    this.color = ProgressIndicatorColor.weak,
    this.size = ProgressIndicatorSize.medium,
  });
  final ProgressIndicatorColor color;
  final ProgressIndicatorSize size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: const ValueKey('loading'),
      width: size.size,
      height: size.size,
      child: CircularProgressIndicator(
        strokeAlign: 1,
        strokeWidth: 2,
        strokeCap: StrokeCap.round,
        color: color.color(context.colors),
      ),
    );
  }
}

extension ProgressIndicatorColorExtension on ProgressIndicatorColor {
  Color color(LmuColors colors) {
    switch (this) {
      case ProgressIndicatorColor.weak:
        return colors.neutralColors.textColors.weakColors.base;
      case ProgressIndicatorColor.strong:
        return colors.neutralColors.textColors.strongColors.base;
    }
  }
}

extension ProgressIndicatorSizeExtension on ProgressIndicatorSize {
  double get size {
    switch (this) {
      case ProgressIndicatorSize.small:
        return LmuIconSizes.small;
      case ProgressIndicatorSize.medium:
        return LmuIconSizes.medium;
      case ProgressIndicatorSize.large:
        return LmuIconSizes.large;
    }
  }
}
