import 'dart:ui';

import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LmuInListBlurEmoji extends StatelessWidget {
  const LmuInListBlurEmoji({super.key, required this.emoji});

  final String emoji;

  @override
  Widget build(BuildContext context) {
    final themeProvider = GetIt.I.get<ThemeProvider>();

    return Container(
      width: LmuSizes.size_48,
      height: LmuSizes.size_48,
      decoration: ShapeDecoration(
        color: context.colors.neutralColors.backgroundColors.mediumColors.base,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(LmuSizes.size_6),
        ),
      ),
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(LmuSizes.size_6),
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(
                    sigmaX: LmuSizes.size_16, sigmaY: LmuSizes.size_16),
                child: ListenableBuilder(
                  listenable: themeProvider,
                  builder: (context, _) => Text(
                    emoji,
                    style: const TextStyle(
                      fontSize: LmuSizes.size_24,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                emoji,
                style: const TextStyle(
                  fontSize: LmuSizes.size_24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
