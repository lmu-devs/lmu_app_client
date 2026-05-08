import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import '../../../constants.dart';
import '../../../utils.dart';
import '../../core.dart';

class LmuMarkdownViewer extends StatelessWidget {
  const LmuMarkdownViewer({
    super.key,
    required this.data,
    this.textColor,
  });

  final String data;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    TextStyle? applyColor(TextStyle? style) {
      if (style == null) return null;
      if (textColor != null) return style.copyWith(color: textColor);
      return style;
    }

    return MarkdownBody(
      data: data,
      selectable: true,
      onTapLink: (text, href, title) {
        if (href != null) {
          LmuUrlLauncher.launchWebsite(url: href, context: context);
        }
      },
      styleSheet: MarkdownStyleSheet(
        p: applyColor(textTheme.bodyLarge),

        h1: applyColor(textTheme.headlineMedium),
        h2: applyColor(textTheme.headlineSmall),
        h3: applyColor(textTheme.titleMedium),
        h4: applyColor(textTheme.titleSmall),
        h5: applyColor(textTheme.titleSmall),
        h6: applyColor(textTheme.titleSmall),

        listBullet: applyColor(textTheme.bodyLarge),

        a: applyColor(textTheme.bodyLarge)?.copyWith(
          color: context.colors.brandColors.textColors.strongColors.base,
          decoration: TextDecoration.underline,
          decorationColor: context.colors.brandColors.textColors.strongColors.base,
        ),

        strong: applyColor(textTheme.bodyLarge)?.copyWith(
          fontWeight: FontWeight.bold,
        ),

        em: applyColor(textTheme.bodyLarge)?.copyWith(
          fontStyle: FontStyle.italic,
        ),

        blockquote: applyColor(textTheme.bodyLarge)?.copyWith(
          color: (textColor ?? textTheme.bodyLarge?.color)?.withOpacity(0.7),
          fontStyle: FontStyle.italic,
        ),

        blockSpacing: LmuSizes.size_16,
      ),
    );
  }
}
