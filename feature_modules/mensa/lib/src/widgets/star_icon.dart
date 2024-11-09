import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StarIcon extends StatelessWidget {
   const StarIcon({Key? key, this.isActive = false}):super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/star.svg",
      semanticsLabel: 'Star',
      package: "mensa",
      width: LmuSizes.large,
      colorFilter: ColorFilter.mode(
        isActive
            ? context.colors.warningColors.textColors.strongColors.base
            : context.colors.neutralColors.backgroundColors.base,
        BlendMode.srcIn,
      ),
    );
  }
}
