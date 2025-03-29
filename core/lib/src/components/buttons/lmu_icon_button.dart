import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/widgets.dart';

class LmuIconButton extends StatelessWidget {
  const LmuIconButton({super.key, required this.icon, required this.onPressed, this.isDisabled = false});

  final IconData icon;
  final void Function() onPressed;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(LmuSizes.size_8),
        decoration: BoxDecoration(
          color: isDisabled
              ? colors.neutralColors.backgroundColors.mediumColors.disabled
              : colors.neutralColors.backgroundColors.mediumColors.base,
          borderRadius: BorderRadius.circular(LmuSizes.size_8),
        ),
        child: LmuIcon(
          icon: icon,
          size: LmuIconSizes.mediumSmall,
          color: isDisabled ? colors.neutralColors.textColors.weakColors.disabled! : null,
        ),
      ),
    );
  }
}
