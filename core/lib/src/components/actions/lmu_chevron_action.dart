import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../../../components.dart';
import '../../../constants.dart';
import '../../../themes.dart';

class LmuChevronAction extends StatelessWidget {
  const LmuChevronAction({super.key, this.chevronTitle});

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
          icon: LucideIcons.chevron_right,
          size: LmuIconSizes.medium,
          color: iconColor,
        ),
      ],
    );
  }
}
