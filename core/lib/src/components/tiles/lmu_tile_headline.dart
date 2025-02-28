import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuTileHeadline extends StatelessWidget {
  final String title;
  final String? trailingTitle;
  final String? actionTitle;
  final void Function()? onActionTap;
  final Widget? bottomWidget;
  final double? customBottomPadding;

  const LmuTileHeadline._internal({
    super.key,
    required this.title,
    this.trailingTitle,
    this.actionTitle,
    this.onActionTap,
    this.bottomWidget,
    this.customBottomPadding,
  });

  factory LmuTileHeadline.base({
    Key? key,
    required String title,
    String? trailingTitle,
    Widget? bottomWidget,
    double? customBottomPadding,
  }) =>
      LmuTileHeadline._internal(
        key: key,
        title: title,
        trailingTitle: trailingTitle,
        bottomWidget: bottomWidget,
        customBottomPadding: customBottomPadding,
      );

  factory LmuTileHeadline.action({
    Key? key,
    required String title,
    required String actionTitle,
    required void Function() onActionTap,
    Widget? bottomWidget,
    double? customBottomPadding,
  }) =>
      LmuTileHeadline._internal(
        key: key,
        title: title,
        actionTitle: actionTitle,
        onActionTap: onActionTap,
        bottomWidget: bottomWidget,
        customBottomPadding: customBottomPadding,
      );

  @override
  Widget build(BuildContext context) {
    final textColors = context.colors.neutralColors.textColors;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LmuText.body(
              title,
              weight: FontWeight.w600,
              color: textColors.mediumColors.base,
            ),
            if (trailingTitle != null)
              LmuText.body(
                trailingTitle,
                weight: FontWeight.w600,
                color: textColors.weakColors.base,
              ),
            if (actionTitle != null)
              LmuButton(
                title: actionTitle!,
                onTap: onActionTap,
                emphasis: ButtonEmphasis.link,
                size: ButtonSize.large,
              ),
          ],
        ),
        SizedBox(height: customBottomPadding ?? LmuSizes.size_12),
        if (bottomWidget != null)
          Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 36,
                ),
                child: bottomWidget!,
              ),
              const SizedBox(height: LmuSizes.size_16),
            ],
          ),
      ],
    );
  }
}
