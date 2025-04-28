import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/src/constants/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StarIcon extends StatelessWidget {
  const StarIcon({
    Key? key,
    this.isActive = false,
    this.disabledColor,
    this.size = LmuIconSizes.mediumSmall,
  }) : super(key: key);

  final bool isActive;
  final Color? disabledColor;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final localization = context.locals.app;
    final colors = context.colors;
    final disabledLightColor = colors.neutralColors.borderColors.seperatorLight;
    final disabledDarkColor = Colors.black;
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
