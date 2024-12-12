import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_svg/lucide_icons_svg.dart';

class LmuCheckboxAction extends StatelessWidget {
  const LmuCheckboxAction({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final enabledColor = context.colors.brandColors.backgroundColors.nonInvertableColors.base;
    final disabledColor = context.colors.neutralColors.backgroundColors.strongColors.pressed!;
    final backgroundColor = context.colors.neutralColors.backgroundColors.base;
    final iconColor = context.colors.neutralColors.backgroundColors.nonInvertableColors.active!;
    const animationDuration = Duration(milliseconds: 120);
    return AnimatedContainer(
      duration: animationDuration,
      curve: Curves.easeOut,
      width: LmuSizes.size_24,
      height: LmuSizes.size_24,
      decoration: BoxDecoration(
        border: Border.all(
          color: isActive ? enabledColor : disabledColor,
          width: LmuSizes.size_2,
        ),
        borderRadius: BorderRadius.circular(LmuSizes.size_4),
        color: isActive ? enabledColor : backgroundColor,
      ),
      child: AnimatedOpacity(
        opacity: isActive ? 1.0 : 0.0,
        duration: animationDuration,
        curve: Curves.easeOut,
        child: Center(
          child: LucideIcon(
            LucideIcons.check,
            size: LmuIconSizes.small,
            strokeWidth: 3,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
