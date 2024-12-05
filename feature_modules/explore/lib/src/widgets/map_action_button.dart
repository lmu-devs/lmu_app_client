import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class MapActionButton extends StatelessWidget {
  const MapActionButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + LmuSizes.size_8,
      right: LmuSizes.size_12,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: context.colors.neutralColors.backgroundColors.tile,
            border: Border.all(color: context.colors.neutralColors.textColors.weakColors.base, width: 0.25),
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(LmuSizes.size_8),
          child: Icon(
            icon,
            size: LmuIconSizes.medium,
          ),
        ),
      ),
    );
  }
}
