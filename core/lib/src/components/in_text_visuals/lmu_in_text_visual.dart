import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LmuInTextVisual extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final bool hasIconBox;
  final bool destructive;

  const LmuInTextVisual._({
    Key? key,
    this.title,
    this.icon,
    this.hasIconBox = false,
    this.destructive = false,
  }) : super(key: key);

  factory LmuInTextVisual.text({
    Key? key,
    required String title,
    bool destructive = false,
  }) =>
      LmuInTextVisual._(
        key: key,
        title: title,
        destructive: destructive,
      );

  factory LmuInTextVisual.iconBox({
    Key? key,
    required IconData icon,
    bool destructive = false,
  }) =>
      LmuInTextVisual._(
        key: key,
        icon: icon,
        hasIconBox: true,
        destructive: destructive,
      );

  factory LmuInTextVisual.icon({
    Key? key,
    required IconData icon,
    bool destructive = false,
  }) =>
      LmuInTextVisual._(
        key: key,
        icon: icon,
        destructive: destructive,
      );

  @override
  Widget build(BuildContext context) {
    final hasIcon = icon != null;

    final backgroundColor = destructive
        ? context.colors.dangerColors.backgroundColors.weakColors.base
        : context.colors.neutralColors.backgroundColors.mediumColors.base;

    final textColor = destructive
        ? context.colors.dangerColors.textColors.strongColors.base
        : context.colors.neutralColors.textColors.mediumColors.base;

    return Container(
      height: LmuSizes.large,
      width: hasIcon ? LmuSizes.large : null,
      decoration: hasIconBox && hasIcon
          ? null
          : BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(LmuSizes.small),
            ),
      padding: EdgeInsets.symmetric(
        horizontal: hasIcon ? LmuSizes.none : LmuSizes.small,
        vertical: hasIcon ? LmuSizes.none : LmuSizes.xsmall,
      ),
      child: _buildChild(textColor),
    );
  }

  Widget _buildChild(Color textColor) {
    if (title != null) {
      return LmuText.caption(
        title!,
        color: textColor,
      );
    } else if (icon != null) {
      return Center(
        child: LmuIcon(
          icon: icon!,
          size: LmuIconSizes.small,
          color: textColor,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
