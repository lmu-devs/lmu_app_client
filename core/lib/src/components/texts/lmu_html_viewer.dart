import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

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
    final textTheme = Theme.of(context).textTheme;
    final linkColor = context.colors.brandColors.textColors.strongColors.base;

    Style styleFrom(TextStyle? base,
        {Color? overrideColor, FontWeight? overrideFontWeight, FontStyle? overrideFontStyle, double? overrideOpacity}) {
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
        'p': styleFrom(textTheme.bodyLarge),
        'h1': styleFrom(textTheme.headlineMedium),
        'h2': styleFrom(textTheme.headlineSmall),
        'h3': styleFrom(textTheme.titleMedium),
        'h4': styleFrom(textTheme.titleSmall),
        'h5': styleFrom(textTheme.titleSmall),
        'h6': styleFrom(textTheme.titleSmall),
        'li': styleFrom(textTheme.bodyLarge),
        'a': styleFrom(
          textTheme.bodyLarge,
          overrideColor: linkColor,
          overrideFontWeight: null,
        ).copyWith(
          textDecoration: TextDecoration.underline,
          textDecorationColor: linkColor,
        ),
        'strong': styleFrom(textTheme.bodyLarge, overrideFontWeight: FontWeight.bold),
        'b': styleFrom(textTheme.bodyLarge, overrideFontWeight: FontWeight.bold),
        'em': styleFrom(textTheme.bodyLarge, overrideFontStyle: FontStyle.italic),
        'i': styleFrom(textTheme.bodyLarge, overrideFontStyle: FontStyle.italic),
        'blockquote': styleFrom(textTheme.bodyLarge, overrideFontStyle: FontStyle.italic, overrideOpacity: 0.7),
      },
    );
  }
}
