import 'package:flutter/widgets.dart';

import '../../../components.dart';
import '../../../constants.dart';
import '../../../themes.dart';

class LmuIconButton extends StatelessWidget {
  const LmuIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.isDisabled = false,
    this.backgroundColor,
  });

  final IconData icon;
  final void Function() onPressed;
  final bool isDisabled;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final mediumColors = colors.neutralColors.backgroundColors.mediumColors;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(LmuSizes.size_8),
        decoration: BoxDecoration(
          color: backgroundColor ?? (isDisabled ? mediumColors.disabled : mediumColors.base),
          borderRadius: BorderRadius.circular(LmuSizes.size_8),
        ),
        child: LmuIcon(
          icon: icon,
          size: LmuIconSizes.mediumSmall * MediaQuery.of(context).textScaler.textScaleFactor,
          color: isDisabled ? colors.neutralColors.textColors.weakColors.disabled! : null,
        ),
      ),
    );
  }
}
