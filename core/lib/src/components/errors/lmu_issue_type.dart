import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LmuIssueType extends StatelessWidget {
  const LmuIssueType({
    super.key,
    required this.message,
    this.hasSpacing = true,
    this.isCentered = true,
  });

  final String message;
  final bool hasSpacing;
  final bool isCentered;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        if (hasSpacing) const SizedBox(height: LmuSizes.size_12),
        Lottie.asset(
          'lib/assets/ghost.json',
          package: 'core',
          height: LmuSizes.size_16 * 10,
          fit: BoxFit.cover,
          repeat: true,
        ),
        const SizedBox(height: LmuSizes.size_2),
        LmuText.body(
          message,
          color: context.colors.neutralColors.textColors.mediumColors.base,
          textAlign: isCentered ? TextAlign.center : TextAlign.start,
        ),
        if (hasSpacing) const SizedBox(height: LmuSizes.size_96),
      ],
    );
  }
}
