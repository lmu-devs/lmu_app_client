import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import 'helper/input_field_color_helper.dart';

enum InputStates {
  base,
  active,
  typing,
  filled,
  loading,
}

class LmuInputField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final bool isMultiline;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool isDisabled;
  final bool isAutocorrect;
  final bool isAutofocus;
  final TextInputType keyboardType;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onTap;
  final void Function()? onTapOutside;
  final void Function()? onClearPressed;
  final Iterable<String>? autofillHints;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefix;
  final BoxConstraints? leadingIconConstraints;
  final Widget? suffix;
  final String? suffixText;
  final bool closeKeyboardOnTapOutside;
  final FocusNode? focusNode;

  const LmuInputField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.isMultiline = false,
    this.leadingIcon,
    this.trailingIcon,
    this.isDisabled = false,
    this.isAutocorrect = false,
    this.isAutofocus = false,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.autofillHints,
    this.contentPadding,
    this.prefix,
    this.leadingIconConstraints,
    this.suffix,
    this.suffixText,
    this.closeKeyboardOnTapOutside = true,
    this.onTapOutside,
    this.focusNode,
    this.onClearPressed,
  });

  @override
  State<LmuInputField> createState() => _LmuInputFieldState();
}

class _LmuInputFieldState extends State<LmuInputField> {
  late final ValueNotifier<InputStates> _stateNotifier;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _stateNotifier = ValueNotifier(InputStates.base);
    _focusNode = widget.focusNode ?? FocusNode();

    widget.controller.addListener(_handleControllerChange);
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _stateNotifier.dispose();
    widget.controller.removeListener(_handleControllerChange);
    _focusNode.removeListener(_handleFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleControllerChange() {
    if (widget.controller.text.isEmpty) {
      if (_focusNode.hasFocus) {
        _stateNotifier.value = InputStates.typing;
      } else {

        _stateNotifier.value = InputStates.base;
      }
    } else {

      _stateNotifier.value = InputStates.filled;
    }
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      if (widget.controller.text.isEmpty) {

        _stateNotifier.value = InputStates.active;
      }
    } else {

      if (widget.controller.text.isEmpty) {
        _stateNotifier.value = InputStates.base;
      }
    }
  }

  void _handleClear() {
    widget.controller.clear();
    widget.onClearPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(LmuRadiusSizes.medium);
    final fillColor = InputFieldColorHelper.getFillColor(context);
    const borderColor = Colors.transparent;

    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword,
      cursorColor: context.colors.brandColors.textColors.strongColors.base,
      enabled: !widget.isDisabled,
      autocorrect: widget.isAutocorrect,
      enableSuggestions: widget.isAutocorrect,
      autofocus: widget.isAutofocus,
      keyboardType: widget.keyboardType,
      maxLength: widget.maxLength,
      minLines: widget.minLines,
      maxLines: widget.isMultiline ? widget.maxLines : 1,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      autofillHints: widget.autofillHints,
      style: TextStyle(
        color: context.colors.neutralColors.textColors.strongColors.base,
      ),
      onTapOutside: (value) {
        if (widget.closeKeyboardOnTapOutside) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
        widget.onTapOutside?.call();
      },
      cursorHeight: 20,
      cursorErrorColor:
          context.colors.dangerColors.textColors.strongColors.base,
      cursorOpacityAnimates: true,
      decoration: InputDecoration(
        contentPadding: widget.contentPadding,
        filled: true,
        fillColor: fillColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: borderColor),
        ),
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: borderColor),
        ),
        hoverColor:
            context.colors.neutralColors.backgroundColors.mediumColors.base,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: context.colors.neutralColors.textColors.weakColors.base,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: widget.leadingIcon,
        prefixIconColor:
            context.colors.neutralColors.textColors.weakColors.base,
        prefixIconConstraints: widget.leadingIconConstraints,
        suffixIcon: widget.trailingIcon,
        suffixIconColor:
            context.colors.neutralColors.textColors.weakColors.base,
        prefix: widget.prefix,
        suffix: widget.suffix,
        suffixText: widget.suffixText,
      ),
      focusNode: _focusNode,
    );
  }
}
