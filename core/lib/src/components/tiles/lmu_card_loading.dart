import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LmuCardLoading extends StatelessWidget {
  const LmuCardLoading({
    super.key,
    this.hasTag = false,
    this.hasSubtitle = false,
    this.subtitleLength = 5,
    this.leadingIcon,
    this.hasFavoriteStar = false,
    this.hasFavoriteCount = false,
    this.hasLargeImage = false,
    this.hasDivider = false,
    this.contentTileType = ContentTileType.middle,
  });

  final bool hasTag;
  final bool hasSubtitle;
  final int subtitleLength;
  final Widget? leadingIcon;
  final bool hasFavoriteStar;
  final bool hasFavoriteCount;
  final bool hasLargeImage;
  final bool hasDivider;
  final ContentTileType contentTileType;

  @override
  Widget build(BuildContext context) {
    return LmuSkeleton(
      child: LmuCard(
        title: BoneMock.title,
        tag: hasTag ? BoneMock.words(1) : null,
        subtitle: hasSubtitle ? BoneMock.words(subtitleLength) : null,
        leadingIcon: leadingIcon,
        hasLargeImage: hasLargeImage,
        imageUrl: "https://upload.wikimedia.org/wikipedia/commons/c/ca/1x1.png",
        hasFavoriteStar: hasFavoriteStar,
        favoriteCount: hasFavoriteCount ? BoneMock.chars(3) : null,
        hasDivider: hasDivider,
        contentTileType: contentTileType,
      ),
    );
  }
}
