import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components.dart';
import '../../../constants.dart';
import '../../../localizations.dart';
import '../../../themes.dart';

class ExpandableText extends StatelessWidget {
  ExpandableText({
    super.key,
    required this.text,
    required this.maxLines,
    required this.amountOfHorizontalPadding,
  });

  final String text;
  final int maxLines;
  final double amountOfHorizontalPadding;
  final ValueNotifier<bool> _isExpanded = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final textSpan = TextSpan(
      text: text,
      style: LmuText.body('').getTextStyle(context),
    );
    final textPainter = TextPainter(
      text: textSpan,
      maxLines: null,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width - amountOfHorizontalPadding);

    final lineCount = textPainter.computeLineMetrics().length;
    final textExceedsMaxLines = lineCount > maxLines + 1;

    return ValueListenableBuilder<bool>(
      valueListenable: _isExpanded,
      builder: (context, isExpanded, child) {
        final displayAll = !textExceedsMaxLines;

        return GestureDetector(
          onTap: () => _isExpanded.value = true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LmuText.body(
                text,
                maxLines: isExpanded || displayAll ? null : maxLines,
                customOverFlow: isExpanded || displayAll ? null : TextOverflow.fade,
              ),
              if (textExceedsMaxLines && !isExpanded)
                Column(
                  children: [
                    const SizedBox(height: LmuSizes.size_8),
                    LmuText.bodyXSmall(
                      context.locals.app.readMore,
                      textStyle: LmuText.bodySmall('').getTextStyle(context).copyWith(
                            color: context.colors.neutralColors.textColors.weakColors.base,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationThickness: 1,
                            decorationColor: context.colors.neutralColors.textColors.weakColors.base,
                          ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
