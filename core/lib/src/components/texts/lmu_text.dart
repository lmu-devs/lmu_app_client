import 'package:flutter/material.dart';

import '../../themes/themes.dart';

class LmuText extends StatelessWidget {
  const LmuText(
    this.text, {
    this.textAlign,
    this.maxLines,
    this.weight,
    this.customOverFlow,
    this.type,
    this.textStyle,
    Color? color,
    bool? isEnabled,
    TextDecoration? decoration = TextDecoration.none,
    super.key,
  })  : _color = color,
        isEnabled = isEnabled ?? true,
        customDecoration = decoration ?? TextDecoration.none;

  factory LmuText.body(
    String? text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    FontWeight? weight,
    double? textScaleFactor,
    bool? isEnabled,
    TextOverflow? customOverFlow,
    TextDecoration? decoration,
    TextStyle? textStyle,
  }) =>
      LmuText(
        text,
        key: key,
        textAlign: textAlign,
        maxLines: maxLines,
        weight: weight,
        color: color,
        textStyle: textStyle,
        isEnabled: isEnabled,
        customOverFlow: customOverFlow,
        decoration: decoration,
        type: LmuTextTypes.body,
      );

  factory LmuText.bodySmall(
    String? text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    FontWeight? weight,
    double? textScaleFactor,
    TextOverflow? customOverFlow,
    TextDecoration? decoration,
    TextStyle? textStyle,
  }) =>
      LmuText(
        text,
        key: key,
        textAlign: textAlign,
        maxLines: maxLines,
        weight: weight,
        color: color,
        textStyle: textStyle,
        customOverFlow: customOverFlow,
        decoration: decoration,
        type: LmuTextTypes.bodySmall,
      );

  factory LmuText.bodyXSmall(
    String? text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    FontWeight? weight,
    double? textScaleFactor,
    TextOverflow? customOverFlow,
    TextDecoration? decoration,
    TextStyle? textStyle,
  }) =>
      LmuText(
        text,
        key: key,
        textAlign: textAlign,
        maxLines: maxLines,
        weight: weight,
        color: color,
        textStyle: textStyle,
        customOverFlow: customOverFlow,
        decoration: decoration,
        type: LmuTextTypes.bodyXSmall,
      );

  factory LmuText.h0(
    String? text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    FontWeight? weight,
    double? textScaleFactor = 1,
    bool? isEnabled,
    TextOverflow? customOverFlow,
    TextDecoration? decoration,
    TextStyle? textStyle,
  }) =>
      LmuText(
        text,
        key: key,
        textAlign: textAlign,
        maxLines: maxLines,
        weight: weight,
        color: color,
        textStyle: textStyle,
        isEnabled: isEnabled,
        customOverFlow: customOverFlow,
        decoration: decoration,
        type: LmuTextTypes.h0,
      );

  factory LmuText.h1(
    String? text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    FontWeight? weight,
    double? textScaleFactor,
    bool? isEnabled,
    TextOverflow? customOverFlow,
    TextDecoration? decoration,
    TextStyle? textStyle,
  }) =>
      LmuText(
        text,
        key: key,
        textAlign: textAlign,
        maxLines: maxLines,
        weight: weight,
        color: color,
        textStyle: textStyle,
        isEnabled: isEnabled,
        customOverFlow: customOverFlow,
        decoration: decoration,
        type: LmuTextTypes.h1,
      );

  factory LmuText.h2(
    String? text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    FontWeight? weight,
    double? textScaleFactor,
    bool? isEnabled,
    TextOverflow? customOverFlow,
    TextDecoration? decoration,
    TextStyle? textStyle,
    bool useH2Explore = false,
  }) =>
      LmuText(
        text,
        key: key,
        textAlign: textAlign,
        maxLines: maxLines,
        weight: weight,
        color: color,
        textStyle: textStyle,
        isEnabled: isEnabled,
        customOverFlow: customOverFlow,
        decoration: decoration,
        type: LmuTextTypes.h2,
      );

  factory LmuText.h3(
    String? text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    FontWeight? weight,
    double? textScaleFactor,
    bool? isEnabled,
    TextOverflow? customOverFlow,
    TextDecoration? decoration,
    TextStyle? textStyle,
  }) =>
      LmuText(
        text,
        key: key,
        textAlign: textAlign,
        maxLines: maxLines,
        weight: weight,
        color: color,
        textStyle: textStyle,
        isEnabled: isEnabled,
        customOverFlow: customOverFlow,
        decoration: decoration,
        type: LmuTextTypes.h3,
      );

  factory LmuText.caption(
    String? text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    FontWeight? weight,
    double? textScaleFactor,
    bool? isEnabled,
    TextOverflow? customOverFlow,
    TextDecoration? decoration,
    TextStyle? textStyle,
  }) =>
      LmuText(
        text,
        key: key,
        textAlign: textAlign,
        maxLines: maxLines,
        weight: weight,
        color: color,
        textStyle: textStyle,
        isEnabled: isEnabled,
        customOverFlow: customOverFlow,
        decoration: decoration,
        type: LmuTextTypes.caption,
      );

  final String? text;
  final TextAlign? textAlign;
  final int? maxLines;
  final FontWeight? weight;
  final Color? _color;
  final TextStyle? textStyle;
  final bool isEnabled;
  final TextOverflow? customOverFlow;
  final TextDecoration? customDecoration;
  final LmuTextTypes? type;

  Color? get color => _color;

  TextStyle getTextStyle(BuildContext context) {
    if (textStyle != null) {
      return textStyle!.copyWith(
        color: color,
        fontWeight: weight,
      );
    }
    final textTheme = getBaseTextTheme(
      "Inter",
      context.colors.neutralColors.textColors,
    );

    TextStyle textStyleTemp;
    switch (type) {
      case LmuTextTypes.body:
        textStyleTemp = textTheme.body;
        break;
      case LmuTextTypes.bodySmall:
        textStyleTemp = textTheme.bodySmall;
        break;
      case LmuTextTypes.bodyXSmall:
        textStyleTemp = textTheme.bodyXSmall;
        break;
      case LmuTextTypes.h0:
        textStyleTemp = textTheme.h0;
        break;
      case LmuTextTypes.h1:
        textStyleTemp = textTheme.h1;
        break;
      case LmuTextTypes.h2:
        textStyleTemp = textTheme.h2;
        break;
      case LmuTextTypes.h3:
        textStyleTemp = textTheme.h3;
        break;
      case LmuTextTypes.caption:
        textStyleTemp = textTheme.caption;
        break;
      default:
        textStyleTemp = textTheme.body;
        break;
    }

    textStyleTemp = textStyleTemp.copyWith(
      fontWeight: weight,
      decoration: customDecoration,
    );

    textStyleTemp = textStyleTemp.copyWith(
      color: color,
    );

    return textStyleTemp;
  }

  @override
  Widget build(BuildContext context) {
    bool? softWrap;
    if (maxLines != null) {
      if (maxLines == 1) {
        softWrap = false;
      } else if (maxLines! > 1) {
        softWrap = true;
      }
    }

    return Text(
      text ?? '',
      overflow: customOverFlow ?? ((maxLines == null || maxLines! <= 1) ? TextOverflow.fade : TextOverflow.ellipsis),
      softWrap: softWrap,
      textAlign: textAlign,
      maxLines: maxLines,
      style: getTextStyle(context),
    );
  }
}

enum LmuTextTypes {
  body,
  bodySmall,
  bodyXSmall,
  h0,
  h1,
  h2,
  h3,
  caption,
}
