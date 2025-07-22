import 'dart:ui';

import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class DeveloperdexEntry extends StatelessWidget {
  const DeveloperdexEntry({
    super.key,
    required this.wasSeen,
    required this.assetName,
  });

  final bool wasSeen;
  final String assetName;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!wasSeen)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LmuSizes.size_12),
              color: context.colors.neutralColors.backgroundColors.tile,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  color: context.colors.neutralColors.textColors.weakColors.disabled!.withAlpha(30),
                  assetName,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  package: "core",
                ),
              ),
            ),
          ),
        if (wasSeen)
          Stack(
            children: [
              Opacity(
                opacity: 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(LmuSizes.size_16),
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(
                      sigmaX: LmuSizes.size_24,
                      sigmaY: LmuSizes.size_24,
                    ),
                    child: Image.asset(
                      assetName,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      package: "core",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(LmuSizes.size_12),
                child: Image.asset(
                  assetName,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  package: "core",
                ),
              ),
            ],
          )
      ],
    );
  }
}
