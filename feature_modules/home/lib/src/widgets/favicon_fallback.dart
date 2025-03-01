import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class FaviconFallback extends StatelessWidget {
  const FaviconFallback({
    super.key,
    this.size = LmuIconSizes.medium,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.neutralColors.backgroundColors.mediumColors.base,
        borderRadius: BorderRadius.circular(LmuRadiusSizes.small),
      ),
      height: size,
      width: size,
      child: Center(
        child: Icon(LucideIcons.link, size: size - (size / 2)),
      ),
    );
  }
}
