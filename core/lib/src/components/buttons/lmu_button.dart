import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class LmuButton extends StatelessWidget {
  const LmuButton({
    super.key,
    required this.title,
    this.onTap,
    this.leadingIcon,
    this.leadingIconColor,
    this.isDropdown,
  });

  final String title;
  final void Function()? onTap;
  final IconData? leadingIcon;
  final Color? leadingIconColor;
  final bool? isDropdown;

  bool get hasLeadingIcon => leadingIcon != null;
  bool get isDropdownButton => isDropdown ?? false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(
          left: hasLeadingIcon ? LmuSizes.mediumSmall : LmuSizes.mediumLarge,
          right: isDropdownButton ? LmuSizes.mediumSmall : LmuSizes.mediumLarge,
          top: LmuSizes.mediumSmall,
          bottom: LmuSizes.mediumSmall,
        ),
        height: 36,
        decoration: BoxDecoration(
          color: context.colors.neutralColors.backgroundColors.tile,
          borderRadius: BorderRadius.circular(LmuSizes.mediumSmall),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasLeadingIcon)
              Row(
                children: [
                  LmuIcon(
                    icon: leadingIcon!,
                    size: LmuSizes.large,
                    color: leadingIconColor,
                  ),
                  const SizedBox(width: LmuSizes.mediumSmall),
                ],
              ),
            LmuText.bodySmall(
              title,
              weight: FontWeight.w600,
            ),
            if (isDropdownButton)
              Row(
                children: [
                  const SizedBox(width: LmuSizes.mediumSmall),
                  LmuIcon(
                    icon: LucideIcons.chevron_down,
                    size: LmuSizes.large,
                    color: leadingIconColor,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
