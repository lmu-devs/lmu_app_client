import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../icons/lmu_icon.dart';

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
    const animationDuration = Duration(milliseconds: 80);
    return AnimatedContainer(
      duration: animationDuration,
      curve: Curves.easeOut,
      width: LmuSizes.xlarge,
      height: LmuSizes.xlarge,
      decoration: BoxDecoration(
        border: Border.all(
          color: isActive ? enabledColor : disabledColor,
          width: LmuSizes.xsmall,
        ),
        borderRadius: BorderRadius.circular(LmuSizes.small),
        color: isActive ? enabledColor : backgroundColor,
      ),
      child: AnimatedOpacity(
        opacity: isActive ? 1.0 : 0.0,
        duration: animationDuration,
        curve: Curves.easeOut,
        child: Center(
          child: LmuIcon(
            icon: Icons.check,
            color: iconColor,
            size: LmuIconSizes.small,
          ),
        ),
      ),
    );
  }
}
