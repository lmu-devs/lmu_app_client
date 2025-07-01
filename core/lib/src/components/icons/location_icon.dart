import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../localizations.dart';
import '../../../themes.dart';
import '../../constants/constants.dart';

class LocationIcon extends StatelessWidget {
  const LocationIcon({
    super.key,
    this.isFocused = false,
    this.size = LmuIconSizes.mediumSmall,
  });

  final bool isFocused;
  final double? size;

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
                curve: isFocused ? Curves.elasticOut : Curves.easeOutCirc,
              ),
            ),
            child: child,
          ),
        );
      },
      child: isFocused
          ? SvgPicture.asset(
              "lib/assets/location.svg",
              package: "core",
              semanticsLabel: localization.iconLocation,
              key: ValueKey(isFocused),
              height: size,
              width: size,
              colorFilter: ColorFilter.mode(
                context.colors.neutralColors.textColors.mediumColors.base,
                BlendMode.srcIn,
              ),
            )
          : Icon(
              LucideIcons.navigation,
              key: ValueKey(isFocused),
              size: size,
              color: context.colors.neutralColors.textColors.mediumColors.base,
            ),
    );
  }
}
