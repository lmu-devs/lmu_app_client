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
  final Color? color;
  const LmuInTextVisual._({
    Key? key,
    this.title,
    this.icon,
    this.hasIconBox = false,
    this.destructive = false,
    this.color,
  }) : super(key: key);

  factory LmuInTextVisual.text({
    Key? key,
    required String title,
    bool destructive = false,
    Color? color,
  }) =>
      LmuInTextVisual._(
        key: key,
        title: title,
        destructive: destructive,
        color: color,
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
        : color?.withOpacity(0.1) ?? context.colors.neutralColors.backgroundColors.mediumColors.base;

    final textColor = destructive
        ? context.colors.dangerColors.textColors.strongColors.base
        : color ?? context.colors.neutralColors.textColors.mediumColors.base;

    return Container(
      height: LmuSizes.size_20,
      width: hasIcon ? LmuSizes.size_20 : null,
      decoration: hasIconBox && hasIcon
          ? null
          : BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(LmuSizes.size_4),
            ),
      padding: EdgeInsets.symmetric(
        horizontal: hasIcon ? LmuSizes.none : LmuSizes.size_4,
        vertical: hasIcon ? LmuSizes.none : LmuSizes.size_2,
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
