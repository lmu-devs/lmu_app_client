import 'dart:ui';

import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomeEmojiTile extends StatelessWidget {
  const HomeEmojiTile({super.key, required this.emoji});

  final String emoji;
  String get firstEmoji => emoji.characters.first;

  @override
  Widget build(BuildContext context) {
    final themeProvider = GetIt.I.get<ThemeProvider>();
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(LmuRadiusSizes.medium),
        ),
      ),
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(LmuRadiusSizes.medium),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned(
              top: -32,
              left: 8,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 64.0, sigmaY: 64.0),
                child: ListenableBuilder(
                  listenable: themeProvider,
                  builder: (context, _) => Text(
                    firstEmoji,
                    style: TextStyle(
                      fontSize: 124,
                      color: Colors.black
                          .withOpacity(PlatformDispatcher.instance.platformBrightness == Brightness.light ? 0.3 : 0.2),
                      letterSpacing: -64,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: LmuSizes.size_24,
              top: LmuSizes.size_16,
              child: Text(
                emoji,
                style: const TextStyle(
                  fontSize: 44,
                  height: 1,
                  letterSpacing: -16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
