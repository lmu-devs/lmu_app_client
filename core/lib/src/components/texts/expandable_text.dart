import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatelessWidget {
  ExpandableText({
    super.key,
    required this.text,
    required this.maxLines,
  });

  final String text;
  final int maxLines;
  final ValueNotifier<bool> _isExpanded = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final textSpan = TextSpan(
      text: text,
      style: LmuText.body('').textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width);

    final textExceedsMaxLines = textPainter.didExceedMaxLines;

    return ValueListenableBuilder<bool>(
      valueListenable: _isExpanded,
      builder: (context, isExpanded, child) {
        return GestureDetector(
          onTap: () => _isExpanded.value = true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LmuText.body(
                text,
                maxLines: isExpanded ? null : maxLines,
                customOverFlow: isExpanded ? null : TextOverflow.fade,
              ),
              if (textExceedsMaxLines && !isExpanded)
                Column(
                  children: [
                    const SizedBox(height: LmuSizes.size_8),
                    LmuText.bodyXSmall(
                      context.locals.app.readMore,
                      color: context.colors.neutralColors.textColors.mediumColors.base,
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
