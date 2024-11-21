import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StarIcon extends StatelessWidget {
  const StarIcon({Key? key, this.isActive = false}) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final localization = context.locals.app;
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
        "assets/star.svg",
        semanticsLabel: localization.iconStar,
        key: ValueKey(isActive),
        package: "mensa",
        width: LmuSizes.large,
        colorFilter: ColorFilter.mode(
          isActive
              ? context.colors.warningColors.textColors.strongColors.base
              : context.colors.neutralColors.backgroundColors.base,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
