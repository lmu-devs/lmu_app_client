import 'package:flutter/material.dart';

import '../../themes/color_schemes.dart';
import '../../themes/text_themes.dart';

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
    double? textScaleFactor,
    Color? color,
    bool? isEnabled,
    TextDecoration? decoration = TextDecoration.none,
    super.key,
  })  : textScaleFactor = (textScaleFactor ?? 1.0) > 2.0 ? 2.0 : textScaleFactor,
        _color = color,
        isEnabled = isEnabled ?? true,
        customDecoration = decoration ?? TextDecoration.none;

  factory JoyText.cover(
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
        type: JoyTextTypes.cover,
        textScaleFactor: textScaleFactor,
        isEnabled: isEnabled,
        customOverFlow: customOverFlow,
        decoration: decoration,
        textStyle: textStyle,
      );

  factory JoyText.point(
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
        type: JoyTextTypes.point,
        textScaleFactor: textScaleFactor,
        isEnabled: isEnabled,
        customOverFlow: customOverFlow,
        decoration: decoration,
      );

  factory JoyText.welcome(
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
        textScaleFactor: textScaleFactor,
        customOverFlow: customOverFlow,
        decoration: decoration,
        type: JoyTextTypes.welcome,
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
        textScaleFactor: textScaleFactor,
        isEnabled: isEnabled,
        customOverFlow: customOverFlow,
        decoration: decoration,
        type: JoyTextTypes.h0,
      );

  factory JoyText.status(
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
        textScaleFactor: textScaleFactor,
        isEnabled: isEnabled,
        customOverFlow: customOverFlow,
        decoration: decoration,
        type: JoyTextTypes.status,
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
        textScaleFactor: textScaleFactor,
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
        textScaleFactor: textScaleFactor,
        isEnabled: isEnabled,
        customOverFlow: customOverFlow,
        decoration: decoration,
        type: useH2Explore ? JoyTextTypes.h2Explore : JoyTextTypes.h2,
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
        textScaleFactor: textScaleFactor,
        isEnabled: isEnabled,
        customOverFlow: customOverFlow,
        decoration: decoration,
        type: JoyTextTypes.h3,
      );

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
        textScaleFactor: textScaleFactor,
        isEnabled: isEnabled,
        customOverFlow: customOverFlow,
        decoration: decoration,
        type: JoyTextTypes.body,
      );

  factory JoyText.label(
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
        textScaleFactor: textScaleFactor,
        isEnabled: isEnabled,
        customOverFlow: customOverFlow,
        decoration: decoration,
        type: JoyTextTypes.label,
      );

  factory JoyText.caption(
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
        textScaleFactor: textScaleFactor,
        isEnabled: isEnabled,
        customOverFlow: customOverFlow,
        decoration: decoration,
        type: JoyTextTypes.caption,
      );

  factory JoyText.hints(
    String? text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    FontWeight? weight,
    double? textScaleFactor,
    bool? isEnabled,
    TextOverflow? customOverFlow,
    TextDecoration decoration = TextDecoration.none,
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
        textScaleFactor: textScaleFactor,
        isEnabled: isEnabled,
        customOverFlow: customOverFlow,
        decoration: decoration,
        type: JoyTextTypes.hints,
      );

  final String? text;
  final TextAlign? textAlign;
  final int? maxLines;
  final FontWeight? weight;
  final double? textScaleFactor;
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
      ColorSchemes.light,
    );

    TextStyle textStyleTemp;
    switch (type) {
      case JoyTextTypes.cover:
        textStyleTemp = textTheme.cover;
        break;
      case JoyTextTypes.point:
        textStyleTemp = textTheme.point;
        break;
      case JoyTextTypes.welcome:
        textStyleTemp = textTheme.welcome;
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
      case JoyTextTypes.status:
        textStyleTemp = textTheme.status;
        break;
      case JoyTextTypes.body:
        textStyleTemp = textTheme.body;
        break;
      case JoyTextTypes.label:
        textStyleTemp = textTheme.label;
        break;
      case JoyTextTypes.caption:
        textStyleTemp = textTheme.caption;
        break;
      case JoyTextTypes.hints:
        textStyleTemp = textTheme.hints;
        break;
      default:
        textStyleTemp = textTheme.body;
        break;
    }

    return textStyleTemp;
  }

  @override
  Widget build(BuildContext context) {
    var softWrap;
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
      textScaleFactor: textScaleFactor,
    );
  }
}

enum JoyTextTypes {
  cover,
  point,
  welcome,
  h0,
  h1,
  h2,
  h2Explore,
  h3,
  status,
  body,
  label,
  caption,
  hints,
}
