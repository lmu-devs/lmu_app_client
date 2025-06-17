import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class LmuCard extends StatelessWidget {
  const LmuCard({
    super.key,
    required this.title,
    this.tag,
    this.tagType = ActionType.base,
    this.customTagColor,
    this.customTagTextColor,
    this.subtitle,
    this.customSubtitle,
    this.leadingIcon,
    this.leadingIconAlignment = CrossAxisAlignment.center,
    this.hasFavoriteStar = false,
    this.favoriteCount,
    this.isFavorite = false,
    this.onFavoriteTap,
    this.imageUrl,
    this.hasLargeImage = false,
    this.hasDivider = false,
    this.contentTileType = ContentTileType.middle,
    this.onTap,
    this.onLongPress,
  });

  final String title;
  final String? tag;
  final ActionType tagType;
  final Color? customTagColor;
  final Color? customTagTextColor;
  final String? subtitle;
  final Widget? customSubtitle;
  final Widget? leadingIcon;
  final CrossAxisAlignment leadingIconAlignment;
  final bool hasFavoriteStar;
  final String? favoriteCount;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;
  final String? imageUrl;
  final bool hasLargeImage;
  final bool hasDivider;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final ContentTileType contentTileType;

  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: hasDivider ? LmuSizes.size_12 : LmuSizes.none),
      child: GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: LmuContentTile(
          contentTileType: contentTileType,
          padding: EdgeInsets.zero,
          contentList: [
            if (hasLargeImage)
              Container(
                height: LmuSizes.size_16 * 10,
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: hasImage
                      ? context.colors.neutralColors.backgroundColors.tile
                      : context.colors.neutralColors.backgroundColors.mediumColors.pressed,
                  shape: const RoundedSuperellipseBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(LmuRadiusSizes.mediumLarge),
                      topRight: Radius.circular(LmuRadiusSizes.mediumLarge),
                    ),
                  ),
                  image: hasImage
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          image: LmuCachedNetworkImageProvider(imageUrl!),
                        )
                      : null,
                ),
                child: hasImage
                    ? null
                    : Icon(
                        LucideIcons.image,
                        size: LmuIconSizes.large,
                        color: context.colors.neutralColors.textColors.mediumColors.base,
                      ),
              ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(LmuSizes.size_16),
                  child: Row(
                    crossAxisAlignment: leadingIconAlignment,
                    children: [
                      if (leadingIcon != null) ...[
                        leadingIcon!,
                        const SizedBox(width: LmuSizes.size_12),
                      ],
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: LmuText.body(
                                          title,
                                          weight: FontWeight.w600,
                                        ),
                                      ),
                                      if (tag != null) ...[
                                        const SizedBox(width: LmuSizes.size_8),
                                        LmuInTextVisual.text(
                                          title: tag!,
                                          actionType: tagType,
                                          textColor: customTagTextColor,
                                          backgroundColor: customTagColor,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                if (favoriteCount != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: LmuSizes.size_2),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: LmuSizes.size_8),
                                        LmuText.bodyXSmall(
                                          favoriteCount,
                                          weight: FontWeight.w400,
                                          color: context.colors.neutralColors.textColors.weakColors.base,
                                        ),
                                        const SizedBox(width: LmuSizes.size_4),
                                        const SizedBox(width: LmuSizes.size_20), //placeholder for star
                                      ],
                                    ),
                                  )
                              ],
                            ),
                            if (subtitle != null)
                              LmuText.body(
                                subtitle!,
                                color: context.colors.neutralColors.textColors.mediumColors.base,
                              ),
                            if (customSubtitle != null) customSubtitle!,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (hasFavoriteStar)
                  Positioned(
                    right: LmuSizes.size_6,
                    top: LmuSizes.size_8,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: onFavoriteTap,
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: StarIcon(isActive: isFavorite),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
