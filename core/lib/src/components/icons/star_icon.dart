import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../localizations.dart';
import '../../../themes.dart';
import '../../constants/constants.dart';

class StarIcon extends StatelessWidget {
  const StarIcon({
    super.key,
    this.isActive = false,
    this.disabledColor,
    this.size = LmuIconSizes.mediumSmall,
  });

  final bool isActive;
  final Color? disabledColor;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final localization = context.locals.app;
    final colors = context.colors;
    final disabledLightColor = colors.neutralColors.borderColors.seperatorLight;
    const disabledDarkColor = Colors.black;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1).animate(
              CurvedAnimation(
                parent: animation,
                curve: isActive ? Curves.elasticOut : Curves.easeOutCirc,
              ),
            ),
            child: child,
          ),
        );
      },
      child: SvgPicture.asset(
        "core/lib/assets/star.svg",
        semanticsLabel: localization.iconStar,
        key: ValueKey(isActive),
        width: size,
        colorFilter: ColorFilter.mode(
          isActive
              ? context.colors.warningColors.textColors.strongColors.base
              : disabledColor ??
                  (Theme.of(context).brightness == Brightness.light ? disabledLightColor : disabledDarkColor),
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
