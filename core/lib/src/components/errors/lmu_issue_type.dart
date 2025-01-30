import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuIssueType extends StatelessWidget {
  const LmuIssueType({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final textColor = context.colors.neutralColors.textColors.mediumColors.base;

    return Column(
      children: [
        const SizedBox(height: LmuSizes.size_16),
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
      ],
    );
  }
}
