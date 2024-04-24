import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;

import '../../themes/themes.dart';

// ignore: must_be_immutable
class JoyButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final ElementType type;
  final ElementSize size;
  final ElementState state;
  Color background;
  final Color foregroundColor;
  final Color defaultBorderColor;
  final bool autoResize;
  final double borderLineWidth;
  final bool removePaddings;
  final MainAxisAlignment horizontalAlignment;

  JoyButton({
    super.key,
    this.text,
    required this.onPressed,
    this.leftIcon,
    this.rightIcon,
    this.size = ElementSize.medium,
    this.state = ElementState.none,
    this.type = ElementType.primary,
    this.background = Colors.black,
    this.foregroundColor = Colors.white,
    this.defaultBorderColor = Colors.black87,
    this.autoResize = true,
    this.borderLineWidth = 1,
    this.removePaddings = false,
    this.horizontalAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    List<Widget> children = [];

    // Determine button colors based on the type
    switch (type) {
      case ElementType.primary:
        background = colorScheme.primary;
        break;
      case ElementType.secondary:
        background = colorScheme.secondary;
        break;
      default:
        background = colorScheme.primary;
    }

    if (leftIcon != null) {
      children.add(Padding(
        padding: EdgeInsets.only(
            right: removePaddings
                ? 0
                : text != null
                    ? (size == ElementSize.large
                        ? 18
                        : size == ElementSize.medium
                            ? 14
                            : 9)
                    : rightIcon != null
                        ? (size == ElementSize.small ? 5 : 10)
                        : 0),
        child: leftIcon!,
      ));
    }

    if (text != null) {
      children.add(Text(
        text!,
        //style: (size == ElementSize.MEDIUM ? DevTextStyle.ElementMedium : size == ElementSize.SMALL ? DevTextStyle.ElementSmall : DevTextStyle.ElementLarge).apply(color: foregroundColor),
      ));
    }

    if (rightIcon != null) {
      children.add(Padding(
        padding: EdgeInsets.only(
            left: removePaddings
                ? 0
                : text != null
                    ? (size == ElementSize.large
                        ? 18
                        : size == ElementSize.medium
                            ? 14
                            : 9)
                    : leftIcon != null
                        ? (size == ElementSize.small ? 5 : 10)
                        : 0),
        child: rightIcon!,
      ));
    }

    return Opacity(
      opacity: state == ElementState.disabled ? 0.48 : 1,
      child: Container(
        color: background,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(16),
        //   // boxShadow:
        //   //     Shadows.getShadow(mode: Theme.of(context).brightness, type: type, shadowType: ShadowType.levitated),
        //   color: background,
        // ),
        child: RawMaterialButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          elevation: 0,
          focusElevation: 0,
          highlightElevation: 0,
          hoverElevation: 0,
          fillColor: Colors.transparent,
          constraints: const BoxConstraints(),
          onPressed: state == ElementState.disabled ? null : onPressed,
          // shape: RoundedRectangleBorder(
          //     side: type == ElementType.PRIMARY
          //         ? BorderSide.none
          //         : BorderSide(
          //             color: defaultBorderColor, width: borderLineWidth),
          //     borderRadius: BorderRadius.all(
          //         Radius.circular(size == ElementSize.SMALL ? 12 : 16))),
          splashColor: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              removePaddings
                  ? 0
                  : (leftIcon != null
                      ? (size == ElementSize.large
                          ? 20
                          : size == ElementSize.medium
                              ? 1
                              : 8)
                      : (size == ElementSize.large ? 20 : (size == ElementSize.small && text == null ? 8 : 16))),
              removePaddings ? 0 : (size == ElementSize.small ? 8 : 16),
              removePaddings
                  ? 0
                  : (rightIcon != null
                      ? (size == ElementSize.large
                          ? 20
                          : size == ElementSize.medium
                              ? 16
                              : 8)
                      : (size == ElementSize.large ? 20 : (size == ElementSize.small && text == null ? 8 : 16))),
              removePaddings ? 0 : (size == ElementSize.small ? 8 : 16),
            ),
            child: Row(
              mainAxisSize: autoResize ? MainAxisSize.min : MainAxisSize.max,
              mainAxisAlignment: horizontalAlignment,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}
