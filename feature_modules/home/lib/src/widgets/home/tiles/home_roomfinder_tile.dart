import 'dart:ui';

import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class HomeRoomfinderTile extends StatelessWidget {
  const HomeRoomfinderTile({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          _mapAsset,
          package: "home",
          fit: BoxFit.cover,
        ),
        Positioned(
          left: LmuSizes.size_16,
          top: LmuSizes.size_16,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: colors.neutralColors.backgroundColors.strongColors.base,
              borderRadius: BorderRadius.circular(LmuRadiusSizes.medium),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(LmuRadiusSizes.medium),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 14.0, sigmaY: 14.0),
                child: Center(
                  child: LmuIcon(
                    icon: LucideIcons.search,
                    size: 20,
                    color: colors.neutralColors.textColors.strongColors.base,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  String get _mapAsset => PlatformDispatcher.instance.platformBrightness == Brightness.light
      ? 'assets/roomfinder_light_placeholder.png'
      : 'assets/roomfinder_tile.png';
}
