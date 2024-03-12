import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'dev_button_models.dart';
import '../../themes/color_primitives.dart';
import '../../themes/styling/shadows.dart';
import 'package:figma_squircle/figma_squircle.dart';

class DevButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final DevButtonSize size;
  final DevButtonState state;
  final DevButtonType type;
  final Color background;
  final Color foregroundColor;
  final Color defaultBorderColor;
  final bool autoResize;
  final double borderLineWidth;
  final bool removePaddings;
  final MainAxisAlignment horizontalAlignment;

  const DevButton({
    super.key,
    this.text,
    required this.onPressed,
    this.leftIcon,
    this.rightIcon,
    this.size = DevButtonSize.MEDIUM,
    this.state = DevButtonState.DEFAULT,
    this.type = DevButtonType.PRIMARY,
    this.background = ColorPrimitives.grey700,
    this.foregroundColor = Colors.white,
    this.defaultBorderColor = ColorPrimitives.grey400,
    this.autoResize = true,
    this.borderLineWidth = 1,
    this.removePaddings = false,
    this.horizontalAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if (leftIcon != null) {
      children.add(Padding(
        padding: EdgeInsets.only(
            right: removePaddings
                ? 0
                : text != null
                    ? (size == DevButtonSize.LARGE
                        ? 18
                        : size == DevButtonSize.MEDIUM
                            ? 14
                            : 9)
                    : rightIcon != null
                        ? (size == DevButtonSize.SMALL ? 5 : 10)
                        : 0),
        child: leftIcon!,
      ));
    }

    if (text != null) {
      children.add(Text(
        text!,
        //style: (size == DevButtonSize.MEDIUM ? DevTextStyle.DevButtonMedium : size == DevButtonSize.SMALL ? DevTextStyle.DevButtonSmall : DevTextStyle.DevButtonLarge).apply(color: foregroundColor),
      ));
    }

    if (rightIcon != null) {
      children.add(Padding(
        padding: EdgeInsets.only(
            left: removePaddings
                ? 0
                : text != null
                    ? (size == DevButtonSize.LARGE
                        ? 18
                        : size == DevButtonSize.MEDIUM
                            ? 14
                            : 9)
                    : leftIcon != null
                        ? (size == DevButtonSize.SMALL ? 5 : 10)
                        : 0),
        child: rightIcon!,
      ));
    }

    return Opacity(
      opacity: state == DevButtonState.DISABLED ? 0.48 : 1,
      child: Container(
        decoration: ShapeDecoration(
          shadows: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.8),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
              BoxShadow(
                color: Color.fromRGBO(255, 255, 255, 0.25),
                blurRadius: 1,
                offset: Offset(0, -1),
                inset: true,
              ),
            ],
          color: background,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: 10,
              cornerSmoothing: .6,
            ),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: RawMaterialButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          elevation: 0,
          focusElevation: 2,
          highlightElevation: 0,
          hoverElevation: 0,
          fillColor: background,
          constraints: const BoxConstraints(),
          onPressed: state == DevButtonState.DISABLED ? null : onPressed,
          // shape: RoundedRectangleBorder(
          //     side: type == DevButtonType.PRIMARY
          //         ? BorderSide.none
          //         : BorderSide(
          //             color: defaultBorderColor, width: borderLineWidth),
          //     borderRadius: BorderRadius.all(
          //         Radius.circular(size == DevButtonSize.SMALL ? 12 : 16))),
          splashColor: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              removePaddings
                  ? 0
                  : (leftIcon != null
                      ? (size == DevButtonSize.LARGE
                          ? 24
                          : size == DevButtonSize.MEDIUM
                              ? 16
                              : 8)
                      : (size == DevButtonSize.LARGE
                          ? 24
                          : (size == DevButtonSize.SMALL && text == null
                              ? 8
                              : 16))),
              removePaddings ? 0 : (size == DevButtonSize.SMALL ? 8 : 16),
              removePaddings
                  ? 0
                  : (rightIcon != null
                      ? (size == DevButtonSize.LARGE
                          ? 24
                          : size == DevButtonSize.MEDIUM
                              ? 16
                              : 8)
                      : (size == DevButtonSize.LARGE
                          ? 24
                          : (size == DevButtonSize.SMALL && text == null
                              ? 8
                              : 16))),
              removePaddings ? 0 : (size == DevButtonSize.SMALL ? 8 : 16),
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
