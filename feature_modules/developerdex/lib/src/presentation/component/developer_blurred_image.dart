import 'dart:ui';

import 'package:core/constants.dart';
import 'package:flutter/material.dart';

class DeveloperBlurredImage extends StatelessWidget {
  const DeveloperBlurredImage({super.key, required this.assetName, this.size = 128});

  final String assetName;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: Padding(
            padding: const EdgeInsets.all(LmuSizes.size_8),
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: LmuSizes.size_24,
                sigmaY: LmuSizes.size_24,
              ),
              child: Image.asset(
                assetName,
                fit: BoxFit.cover,
                width: size,
                height: size,
                package: "developerdex",
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(LmuSizes.size_12),
          child: Image.asset(
            assetName,
            fit: BoxFit.cover,
            width: size,
            height: size,
            package: "developerdex",
          ),
        ),
      ],
    );
  }
}
