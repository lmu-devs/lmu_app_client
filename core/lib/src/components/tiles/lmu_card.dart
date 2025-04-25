import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuCard extends StatelessWidget {
  const LmuCard({
    Key? key,
    required this.title,
    this.tag,
    this.tagType = ActionType.base,
    this.customTagColor,
    this.customTagTextColor,
    this.subtitle,
    this.customSubtitle,
    this.leadingIcon,
    this.hasFavoriteStar = false,
    this.favoriteCount,
    this.isFavorite = false,
    this.onFavoriteTap,
    this.imageUrl,
    this.onTap,
    this.onLongPress,
    this.hasDivider = false,
    this.additionalContent = const [],
    this.contentTileType = ContentTileType.middle,
    this.hasLargeImage = false,
  }) : super(key: key);

  /// The title of the card
  final String title;

  /// Optional tag label (like "Mensa", "TUM", etc.)
  final String? tag;

  /// The type of tag styling to use
  final ActionType tagType;

  /// Optional custom background color for the tag
  final Color? customTagColor;

  /// Optional custom text color for the tag
  final Color? customTagTextColor;

  /// Optional subtitle or description text
  final String? subtitle;

  /// Optional subtitle or description text
  final Widget? customSubtitle;

  /// Optional leading icon or widget (like favicon)
  final Widget? leadingIcon;

  /// List of widgets to display in the trailing area (star, count, etc.)
  final bool hasFavoriteStar;

  ///
  final String? favoriteCount;

  ///
  final bool isFavorite;

  ///
  final VoidCallback? onFavoriteTap;

  /// Optional URL for card image
  final String? imageUrl;

  /// Callback for when the card is tapped
  final VoidCallback? onTap;

  /// Callback for when the card is long pressed
  final VoidCallback? onLongPress;

  /// Whether to show a divider at the bottom of the card
  final bool hasDivider;

  /// Additional content widgets to display below the main content
  final List<Widget> additionalContent;

  /// Type of content tile (affects border radius and borders)
  final ContentTileType contentTileType;

  /// Whether the image should be displayed larger
  final bool hasLargeImage;

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
            // Optional image
            if (imageUrl != null)
              Container(
                height: hasLargeImage ? LmuSizes.size_16 * 10 : LmuSizes.size_16 * 7,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.colors.neutralColors.backgroundColors.tile,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(LmuRadiusSizes.mediumLarge),
                    topRight: Radius.circular(LmuRadiusSizes.mediumLarge),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: LmuCachedNetworkImageProvider(imageUrl!),
                  ),
                ),
              ),

            // Main content
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(LmuSizes.size_16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
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
                            if (additionalContent.isNotEmpty) ...additionalContent,
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

  /// ToDo
  factory LmuCard.loading({
    String? title,
    bool hasLargeImage = false,
    bool hasDivider = true,
    ContentTileType contentTileType = ContentTileType.middle,
  }) {
    return LmuCard(
      title: title ?? 'Loading...',
      hasDivider: hasDivider,
      contentTileType: contentTileType,
      hasLargeImage: hasLargeImage,
    );
  }
}
