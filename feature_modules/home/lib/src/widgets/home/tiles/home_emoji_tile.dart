import 'dart:ui';

import 'package:core/constants.dart';
import 'package:flutter/material.dart';

class HomeEmojiTile extends StatelessWidget {
  const HomeEmojiTile({super.key, required this.emoji});

  final String emoji;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          Positioned(
            top: -32,
            left: 8,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 32.0, sigmaY: 32.0),
              child: Text(
                emoji,
                style: TextStyle(
                  fontSize: 112,
                  color: Colors.black.withOpacity(0.2),
                  letterSpacing: -64,
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
    );
  }
}
