import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

enum ContentTileType { top, middle, bottom }

class LmuContentTile extends StatelessWidget {
  const LmuContentTile({
    required this.content,
    super.key,
    this.contentTileType = ContentTileType.middle,
    this.padding,
  });

  final List<Widget> content;
  final ContentTileType contentTileType;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors.neutralColors;
    if (content.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: padding ?? const EdgeInsets.all(LmuSizes.size_4),
      decoration: BoxDecoration(
        color: colors.backgroundColors.tile,
        borderRadius: contentTileType.borderRadius,
        border: contentTileType.hasBorder
            ? Border(
                bottom: BorderSide(
                  color: colors.borderColors.seperatorLight,
                  width: .5,
                ),
              )
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: content,
      ),
    );
  }
}

extension _ContentTileTypeExtension on ContentTileType {
  BorderRadius get borderRadius {
    return switch (this) {
      ContentTileType.top => const BorderRadius.vertical(top: Radius.circular(LmuRadiusSizes.mediumLarge)),
      ContentTileType.middle => const BorderRadius.all(Radius.circular(LmuRadiusSizes.mediumLarge)),
      ContentTileType.bottom => const BorderRadius.vertical(bottom: Radius.circular(LmuRadiusSizes.mediumLarge)),
    };
  }

  bool get hasBorder {
    return switch (this) {
      ContentTileType.top => true,
      ContentTileType.middle => false,
      ContentTileType.bottom => false,
    };
  }
}
