import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LmuInTextVisual extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final bool hasIconBox;

  const LmuInTextVisual._({
    Key? key,
    this.title,
    this.icon,
    this.hasIconBox = false,
  }) : super(key: key);

  factory LmuInTextVisual.text({
    Key? key,
    required String title,
  }) =>
      LmuInTextVisual._(
        key: key,
        title: title,
      );

  factory LmuInTextVisual.iconBox({
    Key? key,
    required IconData icon,
  }) =>
      LmuInTextVisual._(
        key: key,
        icon: icon,
        hasIconBox: true,
      );

  factory LmuInTextVisual.icon({
    Key? key,
    required IconData icon,
  }) =>
      LmuInTextVisual._(
        key: key,
        icon: icon,
      );

  @override
  Widget build(BuildContext context) {
    final hasIcon = icon != null;
    return Container(
      height: LmuSizes.large,
      width: hasIcon ? LmuSizes.large : null,
      decoration: hasIconBox && hasIcon
          ? null
          : BoxDecoration(
              color: context.colors.neutralColors.backgroundColors.mediumColors.base,
              borderRadius: BorderRadius.circular(LmuSizes.small),
            ),
      padding: EdgeInsets.symmetric(
        horizontal: hasIcon ? LmuSizes.none : LmuSizes.small,
        vertical: hasIcon ? LmuSizes.none : LmuSizes.xsmall,
      ),
      child: _buildChild(context),
    );
  }

  // Helper method to build the child widget
  Widget _buildChild(BuildContext context) {
    if (title != null) {
      return LmuText.caption(
        title!,
        color: context.colors.neutralColors.textColors.mediumColors.base,
      );
    } else if (icon != null) {
      return Center(
        child: LmuIcon(
          icon: icon!,
          size: LmuIconSizes.small,
          color: context.colors.neutralColors.textColors.mediumColors.base,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
