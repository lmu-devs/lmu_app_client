import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import 'developer_blurred_image.dart';

class DeveloperdexEntry extends StatelessWidget {
  const DeveloperdexEntry({
    super.key,
    required this.wasSeen,
    required this.assetName,
    this.onTap,
  });

  final bool wasSeen;
  final String assetName;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          if (!wasSeen)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(LmuSizes.size_12),
                color: context.colors.neutralColors.backgroundColors.tile,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    color: context.colors.neutralColors.textColors.weakColors.disabled!.withAlpha(30),
                    assetName,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    package: "developerdex",
                  ),
                ),
              ),
            ),
          if (wasSeen) DeveloperBlurredImage(assetName: assetName, size: double.infinity),
        ],
      ),
    );
  }
}
