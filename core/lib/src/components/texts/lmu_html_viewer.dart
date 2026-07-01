import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../constants.dart';
import '../../../utils.dart';
import '../../core.dart';

class LmuHtmlViewer extends StatelessWidget {
  const LmuHtmlViewer({
    super.key,
    required this.data,
    this.textColor,
  });

  final String data;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final linkColor = context.colors.brandColors.textColors.strongColors.base;

    Style styleFrom(
      TextStyle? base, {
      Color? overrideColor,
      FontWeight? overrideFontWeight,
      FontStyle? overrideFontStyle,
      double? overrideOpacity,
    }) {
      final baseColor = textColor ?? base?.color;
      final resolvedColor =
          overrideColor ?? (overrideOpacity != null ? baseColor?.withOpacity(overrideOpacity) : baseColor);
      return Style(
        fontSize: base?.fontSize != null ? FontSize(base!.fontSize!) : null,
        fontWeight: overrideFontWeight ?? base?.fontWeight,
        fontStyle: overrideFontStyle ?? base?.fontStyle,
        color: resolvedColor,
        margin: Margins.zero,
        padding: HtmlPaddings.zero,
      );
    }

    return Html(
      data: data,
      onLinkTap: (url, attributes, element) {
        if (url != null) {
          LmuUrlLauncher.launchWebsite(url: url, context: context);
        }
      },
      style: {
        'body': Style(margin: Margins.zero, padding: HtmlPaddings.zero),
        'p': styleFrom(textTheme.body).copyWith(
          margin: Margins.only(bottom: LmuSizes.size_8),
        ),
        'h1': styleFrom(textTheme.h0).copyWith(
          margin: Margins.only(bottom: LmuSizes.size_8, top: 40),
        ),
        'h2': styleFrom(textTheme.h1).copyWith(
          margin: Margins.only(bottom: LmuSizes.size_6, top: LmuSizes.size_32),
        ),
        'h3': styleFrom(textTheme.h2).copyWith(
          margin: Margins.only(bottom: LmuSizes.size_6, top: LmuSizes.size_24),
        ),
        'h4': styleFrom(textTheme.h3).copyWith(
          margin: Margins.only(bottom: LmuSizes.size_4, top: LmuSizes.size_16),
        ),
        'ul': styleFrom(textTheme.body).copyWith(
          margin: Margins.only(left: LmuSizes.size_16),
        ),
        'ol': styleFrom(textTheme.body).copyWith(
          margin: Margins.only(left: LmuSizes.size_24),
        ),
        'li': styleFrom(textTheme.body).copyWith(
          margin: Margins.only(left: LmuSizes.size_4),
        ),
        'a': styleFrom(
          textTheme.body,
          overrideColor: linkColor,
        ).copyWith(
          textDecoration: TextDecoration.underline,
          textDecorationColor: linkColor,
        ),
      },
    );
  }
}
