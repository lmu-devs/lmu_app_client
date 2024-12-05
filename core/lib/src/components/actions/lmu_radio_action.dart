import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuRadioAction extends StatelessWidget {
  const LmuRadioAction({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final enabledColor = context.colors.brandColors.backgroundColors.nonInvertableColors.base;
    final disabledColor = context.colors.neutralColors.backgroundColors.strongColors.pressed!;
    const animationDuration = Duration(milliseconds: 80);

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
        borderRadius: BorderRadius.circular(LmuSizes.size_24),
      ),
      child: AnimatedOpacity(
        opacity: isActive ? 1.0 : 0.0,
        duration: animationDuration,
        curve: Curves.easeOut,
        child: Center(
          child: ClipOval(
            child: Container(
              width: LmuSizes.size_12,
              height: LmuSizes.size_12,
              color: enabledColor,
            ),
          ),
        ),
      ),
    );
  }
}
