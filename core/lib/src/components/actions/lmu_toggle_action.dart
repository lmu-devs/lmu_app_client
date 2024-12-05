import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuToggleAction extends StatelessWidget {
  const LmuToggleAction({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final enabledColor = context.colors.brandColors.backgroundColors.nonInvertableColors.base;
    final disableColor = context.colors.neutralColors.backgroundColors.strongColors.base;
    final knobColor = context.colors.neutralColors.backgroundColors.nonInvertableColors.active;
    return Container(
      width: 46,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LmuSizes.size_32 / 2),
        color: isActive ? enabledColor : disableColor,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutQuad,
            alignment: isActive ? Alignment.centerRight : Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(LmuSizes.size_2),
              child: Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: knobColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
