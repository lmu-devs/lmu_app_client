import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuUnderlineTabBarItem extends StatelessWidget {
  const LmuUnderlineTabBarItem({
    super.key,
    required this.title,
    required this.isActive,
  });

  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LmuText.bodySmall(
          title,
          color: isActive 
            ? context.colors.brandColors.textColors.strongColors.base
            : context.colors.neutralColors.textColors.mediumColors.base,
          weight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
        const SizedBox(height: LmuSizes.size_8),
        AnimatedContainer(
          duration: Durations.short4,
          height: 2,
          width: double.infinity,
          color: isActive 
            ? context.colors.brandColors.textColors.strongColors.base
            : Colors.transparent,
        ),
      ],
    );
  }
}