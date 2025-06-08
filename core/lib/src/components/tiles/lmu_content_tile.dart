import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

enum ContentTileType { top, middle, bottom }

class LmuContentTile extends StatelessWidget {
  const LmuContentTile({
    super.key,
    this.content,
    this.contentList,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.contentTileType = ContentTileType.middle,
    this.padding,
    this.useListView = false,
  }) : assert(content != null || contentList != null);

  final Widget? content;
  final List<Widget>? contentList;
  final CrossAxisAlignment crossAxisAlignment;
  final ContentTileType contentTileType;
  final EdgeInsets? padding;
  final bool useListView;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors.neutralColors;
    return Container(
      padding: padding ?? const EdgeInsets.all(LmuSizes.size_4),
      decoration: ShapeDecoration(
        color: colors.backgroundColors.tile,
        shape: RoundedSuperellipseBorder(
          borderRadius: contentTileType.borderRadius,
          side: contentTileType.hasBorder
              ? BorderSide(
                  color: colors.borderColors.seperatorLight,
                  width: .5,
                )
              : BorderSide.none,
        ),
      ),
      child: content ??
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: crossAxisAlignment,
            children: contentList!,
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
