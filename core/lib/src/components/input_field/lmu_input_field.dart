import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuInputField extends StatelessWidget {
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
  final Iterable<String>? autofillHints;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefix;
  final Widget? suffix;
  final String? suffixText;
  final bool closeKeyboardOnTapOutside;

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
    this.suffix,
    this.suffixText,
    this.closeKeyboardOnTapOutside = true,
    this.onTapOutside,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(LmuRadiusSizes.medium);
    const borderColor = Colors.transparent;
    return TextField(
      controller: controller,
      obscureText: isPassword,
      cursorColor: context.colors.brandColors.textColors.strongColors.base,
      enabled: !isDisabled,
      autocorrect: isAutocorrect,
      enableSuggestions: isAutocorrect,
      autofocus: isAutofocus,
      keyboardType: keyboardType,
      maxLength: maxLength,
      minLines: minLines,
      maxLines: isMultiline ? maxLines : 1,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTap: onTap,
      autofillHints: autofillHints,
      style: TextStyle(
        color: context.colors.neutralColors.textColors.strongColors.base,
      ),
      onTapOutside: (value) {
        if (closeKeyboardOnTapOutside) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
        onTapOutside?.call();
      },
      cursorHeight: 20,
      cursorErrorColor: context.colors.dangerColors.textColors.strongColors.base,
      cursorOpacityAnimates: true,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        filled: true,
        fillColor: _getFillColor(context),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: borderColor),
        ),
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: borderColor),
        ),
        hoverColor: context.colors.neutralColors.backgroundColors.mediumColors.base,
        hintText: hintText,
        hintStyle: TextStyle(
          color: context.colors.neutralColors.textColors.weakColors.base,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: leadingIcon,
        prefixIconColor: context.colors.neutralColors.textColors.weakColors.base,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 56,
        ),
        suffixIcon: trailingIcon,
        suffixIconColor: context.colors.neutralColors.textColors.weakColors.base,
        prefix: prefix,
        suffix: suffix,
        suffixText: suffixText,
      ),
    );
  }

  Color _getFillColor(BuildContext context) {
    return WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return context.colors.neutralColors.backgroundColors.mediumColors.base;
      }
      if (states.contains(WidgetState.focused)) {
        return context.colors.neutralColors.backgroundColors.mediumColors.pressed!;
      }
      if (states.contains(WidgetState.hovered)) {
        return context.colors.neutralColors.backgroundColors.mediumColors.pressed!;
      }
      return context.colors.neutralColors.backgroundColors.mediumColors.base;
    });
  }
}
