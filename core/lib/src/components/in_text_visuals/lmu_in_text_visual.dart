import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../components.dart';
import '../../../constants.dart';
import '../../../themes.dart';

enum ActionType {
  base,
  destructive,
  success,
}

enum InTextVisualSize {
  medium,
  large,
}

class LmuInTextVisual extends StatelessWidget {
  const LmuInTextVisual._({
    super.key,
    this.title,
    this.icon,
    this.hasIconBox = false,
    this.destructive = false,
    this.textColor,
    this.backgroundColor,
    required this.actionType,
    this.size = InTextVisualSize.medium,
  });

  factory LmuInTextVisual.text({
    Key? key,
    required String title,
    bool destructive = false,
    ActionType actionType = ActionType.base,
    Color? textColor,
    Color? backgroundColor,
    InTextVisualSize size = InTextVisualSize.medium,
  }) =>
      LmuInTextVisual._(
        key: key,
        title: title,
        destructive: destructive,
        actionType: actionType,
        textColor: textColor,
        backgroundColor: backgroundColor,
        size: size,
      );

  factory LmuInTextVisual.iconBox({
    Key? key,
    required IconData icon,
    bool destructive = false,
    ActionType actionType = ActionType.base,
    Color? textColor,
    Color? backgroundColor,
    InTextVisualSize size = InTextVisualSize.medium,
  }) =>
      LmuInTextVisual._(
        key: key,
        icon: icon,
        hasIconBox: true,
        actionType: actionType,
        destructive: destructive,
        textColor: textColor,
        backgroundColor: backgroundColor,
        size: size,
      );

  factory LmuInTextVisual.icon({
    Key? key,
    required IconData icon,
    bool destructive = false,
    ActionType actionType = ActionType.base,
    Color? textColor,
    Color? backgroundColor,
    InTextVisualSize size = InTextVisualSize.medium,
  }) =>
      LmuInTextVisual._(
        key: key,
        icon: icon,
        destructive: destructive,
        actionType: actionType,
        textColor: textColor,
        backgroundColor: backgroundColor,
        size: size,
      );

  final String? title;
  final IconData? icon;
  final bool hasIconBox;
  final bool destructive;
  final ActionType actionType;
  final Color? textColor;
  final Color? backgroundColor;
  final InTextVisualSize size;

  @override
  Widget build(BuildContext context) {
    final hasIcon = icon != null;
    final colors = context.colors;

    final double iconSize = size == InTextVisualSize.large ? LmuIconSizes.medium : LmuIconSizes.small;
    final horizontalPadding = hasIcon ? LmuSizes.size_4 : size == InTextVisualSize.medium ? LmuSizes.size_4 : LmuSizes.size_6;
    final verticalPadding = size == InTextVisualSize.large ? LmuSizes.size_4 : LmuSizes.size_2;

    return Container(
      decoration: hasIconBox && hasIcon
          ? null
          : ShapeDecoration(
              color: backgroundColor ?? actionType.backgroundColor(colors),
              shape: RoundedSuperellipseBorder(
                borderRadius: BorderRadius.circular(LmuSizes.size_4),
              ),
            ),
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: _buildChild(textColor ?? actionType.textColor(colors), iconSize),
    );
  }

  Widget _buildChild(Color textColor, double iconSize) {
    if (title != null) {
      if (size == InTextVisualSize.medium) {
        return LmuText.caption(
          title!,
          color: textColor,
        );
      } else {
        return LmuText.bodyXSmall(
          title!,
          color: textColor,
        );
      }
    } else if (icon != null) {
      return LmuIcon(
        icon: icon!,
        size: iconSize,
        color: textColor,
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

extension _ActionTypeColorExtension on ActionType {
  Color backgroundColor(LmuColors colors) {
    return switch (this) {
      ActionType.base => colors.neutralColors.backgroundColors.mediumColors.base,
      ActionType.destructive => colors.dangerColors.backgroundColors.weakColors.base,
      ActionType.success => colors.brandColors.backgroundColors.mediumColors.base,
    };
  }

  Color textColor(LmuColors colors) {
    return switch (this) {
      ActionType.base => colors.neutralColors.textColors.mediumColors.base,
      ActionType.destructive => colors.dangerColors.textColors.strongColors.base,
      ActionType.success => colors.successColors.textColors.strongColors.base,
    };
  }
}
