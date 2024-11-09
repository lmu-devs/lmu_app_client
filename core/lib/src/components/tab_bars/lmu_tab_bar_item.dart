import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuTabBarItemData {
  const LmuTabBarItemData({
    required this.title,
    this.leadingIcon,
    this.trailingIcon,
  });

  final String title;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
}

class LmuTabBarItem extends StatelessWidget {
  const LmuTabBarItem({
    super.key,
    required this.title,
    this.isActive = false,
    this.onTap,
    this.leadingIcon,
    this.trailingIcon,
  });

  final String title;
  final bool isActive;
  final void Function()? onTap;
  final IconData? leadingIcon;
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    final defaultColor = context.colors.neutralColors.textColors.mediumColors.base;
    final activeColor = context.colors.neutralColors.textColors.strongColors.base;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Durations.short4,
        height: 36.0,
        padding: const EdgeInsets.all(LmuSizes.mediumSmall),
        decoration: BoxDecoration(
          color: isActive ? context.colors.neutralColors.backgroundColors.mediumColors.base : Colors.transparent,
          borderRadius: BorderRadius.circular(LmuSizes.mediumSmall),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leadingIcon != null)
              Padding(
                padding: const EdgeInsets.only(right: LmuSizes.mediumSmall),
                child: SizedBox(
                  width: LmuSizes.large,
                  height: LmuSizes.large,
                  child: LmuIcon(
                    icon: leadingIcon!,
                    size: LmuSizes.large,
                    color: isActive ? activeColor : defaultColor,
                  ),
                ),
              ),
            LmuText.bodySmall(
              title,
              color: isActive ? activeColor : defaultColor,
              //weight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
            if (trailingIcon != null)
              Padding(
                padding: const EdgeInsets.only(left: LmuSizes.mediumSmall),
                child: SizedBox(
                  width: LmuSizes.large,
                  height: LmuSizes.large,
                  child: LmuIcon(
                    icon: trailingIcon!,
                    size: LmuSizes.large,
                    color: isActive ? activeColor : defaultColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
