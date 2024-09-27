import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuChevronAction extends StatelessWidget {
  const LmuChevronAction({
    Key? key,
    this.chevronTitle,
  }) : super(key: key);

  final String? chevronTitle;

  @override
  Widget build(BuildContext context) {
    final textColor = context.colors.neutralColors.textColors.mediumColors.base;
    final iconColor = context.colors.neutralColors.textColors.weakColors.base;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        chevronTitle != null
            ? LmuText.body(
                chevronTitle,
                color: textColor,
              )
            : const SizedBox.shrink(),
        LmuIcon(
          icon: Icons.chevron_right,
          size: LmuIconSizes.medium,
          color: iconColor,
        ),
      ],
    );
  }
}
