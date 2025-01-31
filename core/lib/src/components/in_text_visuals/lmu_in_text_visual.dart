import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum ActionType {
  base,
  destructive,
  success,
}

class LmuInTextVisual extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final bool hasIconBox;
  final bool destructive;
  final ActionType actionType;
  final Color? textColor;
  final Color? backgroundColor;

  const LmuInTextVisual._({
    Key? key,
    this.title,
    this.icon,
    this.hasIconBox = false,
    this.destructive = false,
    this.textColor,
    this.backgroundColor,
    required this.actionType,
  }) : super(key: key);

  factory LmuInTextVisual.text({
    Key? key,
    required String title,
    bool destructive = false,
    ActionType actionType = ActionType.base,
    Color? textColor,
    Color? backgroundColor,
  }) =>
      LmuInTextVisual._(
        key: key,
        title: title,
        destructive: destructive,
        actionType: actionType,
        textColor: textColor,
        backgroundColor: backgroundColor,
      );

  factory LmuInTextVisual.iconBox({
    Key? key,
    required IconData icon,
    bool destructive = false,
    ActionType actionType = ActionType.base,
    Color? textColor,
    Color? backgroundColor,
  }) =>
      LmuInTextVisual._(
        key: key,
        icon: icon,
        hasIconBox: true,
        actionType: actionType,
        destructive: destructive,
        textColor: textColor,
        backgroundColor: backgroundColor,
      );

  factory LmuInTextVisual.icon({
    Key? key,
    required IconData icon,
    bool destructive = false,
    ActionType actionType = ActionType.base,
    Color? textColor,
    Color? backgroundColor,
  }) =>
      LmuInTextVisual._(
        key: key,
        icon: icon,
        destructive: destructive,
        actionType: actionType,
        textColor: textColor,
        backgroundColor: backgroundColor,
      );

  @override
  Widget build(BuildContext context) {
    final hasIcon = icon != null;

    final colors = context.colors;

    return Container(
      height: LmuSizes.size_20,
      width: hasIcon ? LmuSizes.size_20 : null,
      decoration: hasIconBox && hasIcon
          ? null
          : BoxDecoration(
              color: backgroundColor ?? actionType.backgroundColor(colors),
              borderRadius: BorderRadius.circular(LmuSizes.size_4),
            ),
      padding: EdgeInsets.symmetric(
        horizontal: hasIcon ? LmuSizes.none : LmuSizes.size_4,
        vertical: hasIcon ? LmuSizes.none : LmuSizes.size_2,
      ),
      child: _buildChild(textColor ?? actionType.textColor(colors)),
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
