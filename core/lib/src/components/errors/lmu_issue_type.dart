import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuIssueType extends StatelessWidget {
  const LmuIssueType({
    super.key,
    required this.title,
    required this.icon,
    this.hasSpacing = true,
  });

  final String title;
  final IconData icon;
  final bool hasSpacing;

  @override
  Widget build(BuildContext context) {
    final textColor = context.colors.neutralColors.textColors.mediumColors.base;

    return Column(
      children: [
        if (hasSpacing) const SizedBox(height: LmuSizes.size_24),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: LmuSizes.size_8),
            LmuIcon(icon: icon, size: LmuIconSizes.small, color: textColor),
            const SizedBox(width: LmuSizes.size_8),
            LmuText.body(title, color: textColor, textAlign: TextAlign.center),
            const SizedBox(width: LmuSizes.size_8),
            LmuIcon(icon: icon, size: LmuIconSizes.small, color: textColor),
          ],
        ),
        const SizedBox(height: LmuSizes.size_12),
        Image.asset(
          "core/lib/assets/sad.gif",
          width: 200,
        ),
        if (hasSpacing) const SizedBox(height: LmuSizes.size_112),
      ],
    );
  }
}
