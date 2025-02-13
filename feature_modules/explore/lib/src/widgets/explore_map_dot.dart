import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../services/explore_map_service.dart';

class ExploreMapDot extends StatelessWidget {
  const ExploreMapDot({
    super.key,
    required this.dotColor,
    required this.icon,
    required this.markerSize,
  });

  final Color dotColor;
  final IconData icon;
  final ExploreMarkerSize markerSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: LmuSizes.size_20,
      height: LmuSizes.size_20,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: markerSize.size,
          height: markerSize.size,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: context.colors.neutralColors.borderColors.iconOutline,
              width: markerSize == ExploreMarkerSize.small ? 1 : 2,
            ),
          ),
          child: markerSize == ExploreMarkerSize.large
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

extension on ExploreMarkerSize {
  double get size {
    return switch (this) {
      ExploreMarkerSize.small => 5,
      ExploreMarkerSize.medium => 10,
      ExploreMarkerSize.large => LmuSizes.size_20,
    };
  }
}
