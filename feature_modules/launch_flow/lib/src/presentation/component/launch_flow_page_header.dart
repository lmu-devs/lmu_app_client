import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LaunchFlowPageHeader extends StatelessWidget {
  const LaunchFlowPageHeader({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: LmuSizes.size_48),
        LmuText.h1(title, textAlign: TextAlign.center),
        const SizedBox(height: LmuSizes.size_8),
        LmuText.body(
          description,
          textAlign: TextAlign.center,
          color: context.colors.neutralColors.textColors.mediumColors.base,
        ),
        const SizedBox(height: LmuSizes.size_48),
      ],
    );
  }
}
