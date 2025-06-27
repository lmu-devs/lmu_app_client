import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../components.dart';
import '../../../constants.dart';
import '../../../themes.dart';

enum BadgeType {
  base,
  destructive,
  success,
}

enum InTextVisualSize {
  medium,
  large,
}

class LmuTextBadge extends StatelessWidget {
  const LmuTextBadge({
    super.key,
    this.title,
    this.leadingIcon,
    this.textColor,
    this.backgroundColor,
    this.badgeType = BadgeType.base,
    this.size = InTextVisualSize.medium,
  });

  final String? title;
  final IconData? leadingIcon;
  final Color? textColor;
  final Color? backgroundColor;
  final BadgeType badgeType;
  final InTextVisualSize size;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textColor = this.textColor ?? badgeType.textColor(colors);

    final double iconSize = size == InTextVisualSize.large ? LmuIconSizes.medium : LmuIconSizes.small;
    final horizontalPadding = size == InTextVisualSize.large ? LmuSizes.size_8 : LmuSizes.size_4;
    final verticalPadding = size == InTextVisualSize.large ? LmuSizes.size_4 : LmuSizes.size_2;

    return Container(
      decoration: ShapeDecoration(
              color: backgroundColor ?? badgeType.backgroundColor(colors),
              shape: RoundedSuperellipseBorder(
                borderRadius: BorderRadius.circular(LmuRadiusSizes.small),
              ),
            ),
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null) ...[
            LmuIcon(
              icon: leadingIcon!,
              size: iconSize,
              color: textColor,
            ),
            SizedBox(width: horizontalPadding),
          ],
          if (title != null)
            size == InTextVisualSize.medium ? LmuText.caption(
              title!,
              color: textColor,
            ) : LmuText.bodyXSmall(
              title!,
              color: textColor,
            ),
        ],
      ),
    );
  }
}

extension _BadgeTypeColorExtension on BadgeType {
  Color backgroundColor(LmuColors colors) {
    return switch (this) {
      BadgeType.base => colors.neutralColors.backgroundColors.mediumColors.base,
      BadgeType.destructive => colors.dangerColors.backgroundColors.weakColors.base,
      BadgeType.success => colors.brandColors.backgroundColors.mediumColors.base,
    };
  }

  Color textColor(LmuColors colors) {
    return switch (this) {
      BadgeType.base => colors.neutralColors.textColors.mediumColors.base,
      BadgeType.destructive => colors.dangerColors.textColors.strongColors.base,
      BadgeType.success => colors.successColors.textColors.strongColors.base,
    };
  }
}
