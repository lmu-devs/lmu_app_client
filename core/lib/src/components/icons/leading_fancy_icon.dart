import 'package:core/src/core.dart';
import 'package:flutter/cupertino.dart';

import '../../../components.dart';
import '../../../constants.dart';

class LeadingFancyIcons extends StatelessWidget {
  const LeadingFancyIcons({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = context.colors.neutralColors.backgroundColors.mediumColors.base;
    return Container(
      width: LmuSizes.size_48,
      height: LmuSizes.size_48,
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(LmuSizes.size_8),
        ),
      ),
      child: LmuIcon(
        size: LmuIconSizes.medium,
        icon: icon,
        color: context.colors.neutralColors.textColors.strongColors.base,
      ),
    );
  }
}
