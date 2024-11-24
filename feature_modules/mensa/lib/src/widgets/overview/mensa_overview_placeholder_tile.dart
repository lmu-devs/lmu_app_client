import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class MensaOverviewPlaceholderTile extends StatelessWidget {
  const MensaOverviewPlaceholderTile({
    super.key,
    required this.title,
    this.icon,
    this.leadingWidget,
  });

  final String title;
  final IconData? icon;
  final Widget? leadingWidget;

  @override
  Widget build(BuildContext context) {
    final color = context.colors.neutralColors.textColors.mediumColors.base;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: LmuSizes.small,
        vertical: LmuSizes.large,
      ),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leadingWidget != null) leadingWidget!,
          if (icon != null)
            LmuIcon(
              icon: icon!,
              size: LmuIconSizes.small,
              color: color,
            ),
          const SizedBox(width: LmuSizes.mediumSmall),
          Flexible(
            child: LmuText.body(
              title,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
