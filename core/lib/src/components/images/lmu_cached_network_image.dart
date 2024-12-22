import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_svg/lucide_icons_svg.dart';

class LmuCachedNetworkImage extends StatelessWidget {
  const LmuCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      errorWidget: (context, url, error) {
        return Container(
          width: width,
          height: height,
          color: context.colors.neutralColors.backgroundColors.mediumColors.base,
          child: Center(
            child: LucideIcon(
              LucideIcons.image,
              size: LmuSizes.size_48,
              strokeWidth: 1.5,
              color: context.colors.neutralColors.textColors.weakColors.base,
            ),
          ),
        );
      },
      fadeInDuration: const Duration(milliseconds: 200),
      fadeOutDuration: const Duration(milliseconds: 200),
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        color: context.colors.neutralColors.backgroundColors.base,
      ),
    );
  }
}
