import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../themes.dart';
import '../images/lmu_cached_network_image.dart';

class LmuInListImage extends StatelessWidget {
  const LmuInListImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
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
        child: LmuCachedNetworkImage(
          imageUrl: imageUrl,
          width: LmuSizes.size_48,
          height: LmuSizes.size_48,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
