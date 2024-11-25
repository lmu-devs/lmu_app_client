import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final bool isMultiline;
  final Widget? icon;
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
  final Iterable<String>? autofillHints;

  const LmuInputField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.isMultiline = false,
    this.icon,
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
  });

  @override
  Widget build(BuildContext context) {
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
        // close keyboard
        FocusManager.instance.primaryFocus?.unfocus();
      },
      cursorHeight: 20,
      cursorErrorColor: context.colors.dangerColors.textColors.strongColors.base,
      cursorOpacityAnimates: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: _getFillColor(context),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(LmuRadiusSizes.medium),
          borderSide: BorderSide(
            width: .5,
            color: context.colors.neutralColors.borderColors.seperatorLight,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: .5,
            color: context.colors.neutralColors.borderColors.seperatorLight,
          ),
          borderRadius: BorderRadius.circular(LmuRadiusSizes.medium),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: .5,
            color: context.colors.neutralColors.borderColors.seperatorLight,
          ),
          borderRadius: BorderRadius.circular(LmuRadiusSizes.medium),
        ),
        hoverColor:
            context.colors.neutralColors.backgroundColors.mediumColors.base,
        hintText: hintText,
        hintStyle: TextStyle(
          color: context.colors.neutralColors.textColors.weakColors.base,
          fontWeight: FontWeight.w400,
        ),
        icon: icon,
        // cursor color
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
      // Default state
      return context.colors.neutralColors.backgroundColors.mediumColors.base;
    });
  }
}
