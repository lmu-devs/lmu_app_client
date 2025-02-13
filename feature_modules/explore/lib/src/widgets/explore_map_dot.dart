import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class ExploreMapDot extends StatelessWidget {
  const ExploreMapDot({
    super.key,
    required this.dotColor,
    required this.icon,
    this.isExpanded = false,
  });

  final Color dotColor;
  final IconData icon;

  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: LmuSizes.size_20,
      height: LmuSizes.size_20,
      child: Center(
        child: Container(
          width: isExpanded ? LmuSizes.size_20 : 10,
          height: isExpanded ? LmuSizes.size_20 : 10,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: context.colors.neutralColors.borderColors.iconOutline,
              width: LmuSizes.size_2,
            ),
          ),
          child: isExpanded
              ? LmuIcon(
                  icon: icon,
                  size: 10,
                  color: context.colors.neutralColors.textColors.flippedColors.base,
                )
              : null,
        ),
      ),
    );
  }
}
