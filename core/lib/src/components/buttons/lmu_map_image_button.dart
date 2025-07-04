import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../themes.dart';
import '../../../utils.dart';

class LmuMapImageButton extends StatelessWidget {
  const LmuMapImageButton({super.key, required this.onTap});

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: LmuActionSizes.base,
        width: LmuActionSizes.base,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LmuRadiusSizes.medium),
          border: Border.all(
            color: context.colors.neutralColors.borderColors.seperatorLight,
          ),
          image: DecorationImage(
            image: AssetImage(getPngAssetTheme('lib/assets/maps_icon'), package: "core"),
          ),
        ),
      ),
    );
  }
}
