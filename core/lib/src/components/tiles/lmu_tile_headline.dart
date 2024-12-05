import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuTileHeadline extends StatelessWidget {
  final String title;
  final String? actionTitle;
  final void Function()? onActionTap;
  final Widget? bottomWidget;

  const LmuTileHeadline._internal({
    super.key,
    required this.title,
    this.actionTitle,
    this.onActionTap,
    this.bottomWidget,
  });

  factory LmuTileHeadline.base({
    Key? key,
    required String title,
    Widget? bottomWidget,
  }) =>
      LmuTileHeadline._internal(
        key: key,
        title: title,
        bottomWidget: bottomWidget,
      );

  factory LmuTileHeadline.action({
    Key? key,
    required String title,
    required String actionTitle,
    required void Function() onActionTap,
    Widget? bottomWidget,
  }) =>
      LmuTileHeadline._internal(
        key: key,
        title: title,
        actionTitle: actionTitle,
        onActionTap: onActionTap,
        bottomWidget: bottomWidget,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LmuText.body(
              title,
              weight: FontWeight.w600,
              color: context.colors.neutralColors.textColors.mediumColors.base,
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
        const SizedBox(height: LmuSizes.size_12),
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
