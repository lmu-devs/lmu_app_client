import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

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
    this.onClose,
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
  final void Function()? onClose;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colors.neutralColors.borderColors.tile, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(LmuRadiusSizes.mediumLarge + 1)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(LmuRadiusSizes.mediumLarge)),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: colors.neutralColors.backgroundColors.tile,
              border: hasBorder
                  ? Border.all(
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: colors.neutralColors.borderColors.seperatorLight,
                      width: 1,
                    )
                  : null,
            ),
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
                // Positioned.fill(
                //   child: Container(
                //     decoration: BoxDecoration(
                //       gradient: LinearGradient(
                //         begin: Alignment.topCenter,
                //         end: Alignment.bottomCenter,
                //         stops: const [0.6, 1],
                //         colors: [
                //           colors.gradientColors.gradientFadeColors.end.withOpacity(0.4),
                //           colors.gradientColors.gradientFadeColors.end.withOpacity(0.8),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
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
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(LmuSizes.size_16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LmuText.body(title, weight: FontWeight.bold),
                        if (subtitle != null)
                          LmuText.body(
                            subtitle,
                            color: colors.neutralColors.textColors.mediumColors.base,
                          ),
                      ],
                    ),
                  ),
                ),

                if (onClose != null)
                  Positioned(
                    right: 4,
                    top: 4,
                    child: GestureDetector(
                      onTap: onClose,
                      behavior: HitTestBehavior.translucent,
                      child: const SizedBox(
                        width: 40,
                        height: 40,
                        child: LmuIcon(
                          icon: LucideIcons.x,
                          size: LmuIconSizes.medium,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
