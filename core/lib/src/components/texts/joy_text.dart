import 'package:core/src/themes/themes.dart';
import 'package:flutter/material.dart';

import '../../themes/texts/text_themes.dart';

class JoyText extends StatelessWidget {
  /// DEPRECATED: Use a factory method instead e.g. JoyText.body(...)
  const JoyText(
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

  factory JoyText.body(
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
      JoyText(
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
        type: JoyTextTypes.body,
      );

  factory JoyText.bodySmall(
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
      JoyText(
        text,
        key: key,
        textAlign: textAlign,
        maxLines: maxLines,
        weight: weight,
        color: color,
        textStyle: textStyle,
        customOverFlow: customOverFlow,
        decoration: decoration,
        type: JoyTextTypes.bodySmall,
      );

  factory JoyText.bodyXSmall(
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
      JoyText(
        text,
        key: key,
        textAlign: textAlign,
        maxLines: maxLines,
        weight: weight,
        color: color,
        textStyle: textStyle,
        customOverFlow: customOverFlow,
        decoration: decoration,
        type: JoyTextTypes.bodyXSmall,
      );

  factory JoyText.h0(
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
      JoyText(
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
        type: JoyTextTypes.h0,
      );

  factory JoyText.h1(
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
      JoyText(
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
        type: JoyTextTypes.h1,
      );

  factory JoyText.h2(
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
      JoyText(
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
        type: JoyTextTypes.h2,
      );

  factory JoyText.h3(
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
      JoyText(
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
        type: JoyTextTypes.h3,
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
  final JoyTextTypes? type;

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
      case JoyTextTypes.body:
        textStyleTemp = textTheme.body;
        break;
      case JoyTextTypes.bodySmall:
        textStyleTemp = textTheme.bodySmall;
        break;
      case JoyTextTypes.bodyXSmall:
        textStyleTemp = textTheme.bodyXSmall;
        break;
      case JoyTextTypes.h0:
        textStyleTemp = textTheme.h0;
        break;
      case JoyTextTypes.h1:
        textStyleTemp = textTheme.h1;
        break;
      case JoyTextTypes.h2:
        textStyleTemp = textTheme.h2;
        break;
      case JoyTextTypes.h3:
        textStyleTemp = textTheme.h3;
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

enum JoyTextTypes {
  body,
  bodySmall,
  bodyXSmall,
  h0,
  h1,
  h2,
  h3,
}
