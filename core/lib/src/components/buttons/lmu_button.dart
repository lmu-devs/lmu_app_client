import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

part 'button_colors_helper.dart';

enum ButtonSize {
  medium,
  large,
}

enum ButtonAction {
  base,
  contrast,
  destructive,
}

enum ButtonEmphasis {
  primary,
  secondary,
  tertiary,
  outline,
  link,
}

enum ButtonState {
  enabled,
  disabled,
  loading,
}

class LmuButton extends StatelessWidget {
  const LmuButton({
    super.key,
    this.size = ButtonSize.medium,
    this.action = ButtonAction.base,
    this.emphasis = ButtonEmphasis.primary,
    this.state = ButtonState.enabled,
    this.title,
    this.leadingWidget,
    this.leadingIcon,
    this.trailingIcon,
    this.onTap,
    this.customSemanticsLabel,
    this.showFullWidth = false,
    this.increaseTouchTarget = false,
  }) : assert(title != null || leadingIcon != null || trailingIcon != null);

  final ButtonSize size;
  final ButtonAction action;
  final ButtonEmphasis emphasis;
  final ButtonState state;
  final String? title;
  final Widget? leadingWidget;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final void Function()? onTap;
  final String? customSemanticsLabel;
  final bool showFullWidth;
  final bool increaseTouchTarget;

  bool get _hasTitle => title != null && !_isLoading;

  bool get _hasLeadingWidget => leadingWidget != null && !_isLoading;

  bool get _hasLeadingIcon => leadingIcon != null && !_isLoading;

  bool get _hasTrailingIcon => trailingIcon != null && !_isLoading;

  bool get _hasTextOnly => emphasis == ButtonEmphasis.link || emphasis == ButtonEmphasis.tertiary;

  bool get _isLoading => state == ButtonState.loading;

  bool get _isOutline => emphasis == ButtonEmphasis.outline;

  bool get _isButtonEnabled => state == ButtonState.enabled;

  double? get _width {
    if (showFullWidth) {
      return double.infinity;
    }
    if (_isLoading) {
      return size.defaultWidth;
    }
    return null;
  }

  EdgeInsetsGeometry? get _padding {
    if (_hasTextOnly) {
      return increaseTouchTarget ? EdgeInsets.symmetric(vertical: size.verticalPadding) : null;
    }
    return EdgeInsets.only(
      left: _hasLeadingWidget || _hasLeadingIcon ? size.smallerVerticalPadding : size.defaultVerticalPadding,
      right:
          _hasTrailingIcon || (!_hasTitle && !_isLoading) ? size.smallerVerticalPadding : size.defaultVerticalPadding,
      top: size.verticalPadding,
      bottom: size.verticalPadding,
    );
  }

  Decoration? _decoration(LmuColors colors, Color backgroundColor) {
    if (_hasTextOnly) {
      return null;
    }
    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(LmuSizes.size_8),
      border: _isOutline
          ? Border.all(
              color: colors.neutralColors.backgroundColors.mediumColors.base,
              width: 1,
              strokeAlign: BorderSide.strokeAlignOutside,
            )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final buttonColors = _getButtonColors(action, emphasis, state);
    final backgroundColor = buttonColors.item1.color(colors);
    final textColor = buttonColors.item2.color(colors);

    return Semantics(
      button: true,
      enabled: _isButtonEnabled,
      label: customSemanticsLabel ?? title,
      child: GestureDetector(
        behavior: increaseTouchTarget ? HitTestBehavior.opaque : HitTestBehavior.deferToChild,
        onTap: _isButtonEnabled ? onTap : null,
        child: Container(
          width: _width,
          padding: _padding,
          decoration: _decoration(colors, backgroundColor),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_hasLeadingWidget)
                Row(
                  children: [
                    leadingWidget!,
                    if (_hasTitle)
                      const SizedBox(
                        width: LmuSizes.size_8,
                      ),
                  ],
                ),
              if (_hasLeadingIcon)
                Row(
                  children: [
                    LmuIcon(
                      icon: leadingIcon!,
                      size: size.iconSize,
                      color: textColor,
                    ),
                    if (_hasTitle)
                      const SizedBox(
                        width: LmuSizes.size_8,
                      ),
                  ],
                ),
              if (_hasTitle)
                size.textWidget(
                  title!,
                  textColor,
                ),
              if (_isLoading)
                SizedBox(
                  width: size.loadingIndicatorSize,
                  height: size.loadingIndicatorSize,
                  child: CircularProgressIndicator(
                    color: textColor,
                    strokeWidth: 3,
                    strokeAlign: -1,
                  ),
                ),
              if (_hasTrailingIcon)
                Row(
                  children: [
                    if (_hasTitle)
                      const SizedBox(
                        width: LmuSizes.size_8,
                      ),
                    LmuIcon(
                      icon: trailingIcon!,
                      size: size.iconSize,
                      color: textColor,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

extension ButtonSizeExtension on ButtonSize {
  Widget textWidget(String title, Color color) {
    switch (this) {
      case ButtonSize.medium:
        return LmuText.bodySmall(
          title,
          weight: FontWeight.w600,
          color: color,
        );
      case ButtonSize.large:
        return LmuText.body(
          title,
          weight: FontWeight.w600,
          color: color,
        );
    }
  }

  double get verticalPadding {
    switch (this) {
      case ButtonSize.medium:
        return LmuSizes.size_8;
      case ButtonSize.large:
        return LmuSizes.size_12;
    }
  }

  double get defaultVerticalPadding {
    switch (this) {
      case ButtonSize.medium:
        return LmuSizes.size_16;
      case ButtonSize.large:
        return LmuSizes.size_20;
    }
  }

  double get smallerVerticalPadding {
    switch (this) {
      case ButtonSize.medium:
        return LmuSizes.size_8;
      case ButtonSize.large:
        return LmuSizes.size_12;
    }
  }

  double get loadingIndicatorSize {
    switch (this) {
      case ButtonSize.medium:
        return LmuSizes.size_20;
      case ButtonSize.large:
        return LmuSizes.size_24;
    }
  }

  double get defaultWidth {
    switch (this) {
      case ButtonSize.medium:
        return 110;
      case ButtonSize.large:
        return 129;
    }
  }

  double get iconSize {
    switch (this) {
      case ButtonSize.medium:
        return LmuIconSizes.small;
      case ButtonSize.large:
        return LmuSizes.size_20;
    }
  }
}
