import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuFeatureTile extends StatelessWidget {
  const LmuFeatureTile({
    super.key,
    required this.title,
    this.content,
    this.subtitle,
    this.padding,
    this.width,
    this.height,
    this.onTap,
    this.hasBorder = false,
  });

  final String title;
  final String? subtitle;
  final Widget? content;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final void Function()? onTap;
  final bool hasBorder;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 170,
        decoration: hasBorder
            ? BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(LmuRadiusSizes.mediumLarge)),
                border: Border.all(
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: colors.neutralColors.borderColors.seperatorLight,
                  width: 1,
                ),
              )
            : null,
        child: Stack(
          children: [
            if (content != null)
              LayoutBuilder(builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: content!,
                );
              }),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(LmuRadiusSizes.mediumLarge)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0, 1],
                    colors: [
                      colors.gradientColors.gradientFadeColors.end.withOpacity(0.5),
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
