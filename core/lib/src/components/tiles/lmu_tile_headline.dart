import 'package:flutter/material.dart';

import '../../../components.dart';
import '../../../constants.dart';
import '../../../themes.dart';

class LmuTileHeadline extends StatelessWidget {
  const LmuTileHeadline._internal({
    super.key,
    required this.title,
    this.trailingTitle,
    this.actionTitle,
    this.onActionTap,
    this.bottomWidget,
    this.customBottomPadding,
    this.isButtonDisabled,
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
    bool isButtonDisabled = false,
  }) =>
      LmuTileHeadline._internal(
        key: key,
        title: title,
        actionTitle: actionTitle,
        onActionTap: onActionTap,
        bottomWidget: bottomWidget,
        customBottomPadding: customBottomPadding,
        isButtonDisabled: isButtonDisabled,
      );

  final String title;
  final String? trailingTitle;
  final String? actionTitle;
  final void Function()? onActionTap;
  final Widget? bottomWidget;
  final double? customBottomPadding;
  final bool? isButtonDisabled;

  @override
  Widget build(BuildContext context) {
    final textColors = context.colors.neutralColors.textColors;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: LmuText.body(
                title,
                weight: FontWeight.w600,
                color: textColors.mediumColors.base,
                maxLines: 3,
                customOverFlow: TextOverflow.ellipsis,
              ),
            ),
            if (trailingTitle != null)
              Flexible(
                child: LmuText.body(
                  trailingTitle,
                  weight: FontWeight.w600,
                  color: textColors.weakColors.base,
                  maxLines: 2,
                  customOverFlow: TextOverflow.ellipsis,
                ),
              ),
            if (actionTitle != null)
              LmuButton(
                title: actionTitle!,
                state: isButtonDisabled!
                    ? ButtonState.disabled
                    : ButtonState.enabled,
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
              bottomWidget!,
              const SizedBox(height: LmuSizes.size_16),
            ],
          ),
      ],
    );
  }
}
