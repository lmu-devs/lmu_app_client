import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuFeatureTile extends StatelessWidget {
  const LmuFeatureTile({
    super.key,
    required this.content,
    required this.title,
    this.subtitle,
    this.padding,
    this.width,
    this.height,
    this.onTap,
  });

  final List<Widget> content;

  final String title;
  final String? subtitle;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            LmuContentTile(content: content, padding: padding),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(LmuRadiusSizes.mediumLarge)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0, 1],
                    colors: [
                      colors.gradientColors.gradientFadeColors.start,
                      colors.gradientColors.gradientFadeColors.end,
                    ],
                  ),
                ),
              ),
            ),
            // Positioned(
            //   child: Container(
            //     padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_2, horizontal: LmuSizes.size_8),
            //     decoration: BoxDecoration(
            //       borderRadius: const BorderRadius.only(
            //         topLeft: Radius.circular(LmuRadiusSizes.mediumLarge),
            //         bottomRight: Radius.circular(LmuRadiusSizes.mediumLarge),
            //       ),
            //       color: context.colors.brandColors.backgroundColors.strongColors.active,
            //     ),
            //     child: LmuText.body("New Offers", weight: FontWeight.w600),
            //   ),
            // ),
            Positioned(
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(LmuSizes.size_16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LmuText.h3(title),
                    if (subtitle != null)
                      LmuText.body(
                        subtitle,
                        color: colors.neutralColors.textColors.mediumColors.base,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
