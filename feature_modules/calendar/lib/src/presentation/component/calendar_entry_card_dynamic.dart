import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../../domain/model/calendar_entry.dart';
import '../../domain/model/event_type.dart';
import '../../domain/model/helper/date_time_formatter.dart';
import '../constants.dart';
import '../view/calendar_event_contentsheet.dart';

class CalendarCard extends StatelessWidget {
  const CalendarCard({
    super.key,
    required this.entry,
    this.fontSizeOverride,
    this.onTap,
  });

  final CalendarEntry entry;
  final double? fontSizeOverride;
  final VoidCallback? onTap;

  static const double _defaultFontSize = 14.0;
  static const double _minHeight20min = (20 / 60) * fixedHeightPerHour;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double currentHeight = constraints.maxHeight;

        final double baseFontSize = fontSizeOverride ?? _defaultFontSize;

        final int titleMaxLines = currentHeight >= _minHeight20min * 4 ? 2 : 1;
        final int timeMaxLines = currentHeight >= _minHeight20min * 6 ? 2 : 1;
        final int locationMaxLines = currentHeight >= _minHeight20min * 5 ? 2 : 1;

        // Visibility logic based on height
        bool showTime = currentHeight >= _minHeight20min * 2.3;
        bool showLocation = currentHeight >= _minHeight20min * 2.8;

        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => CalendarEventBottomSheet(event: entry),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(LmuSizes.size_2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: context.colors.neutralColors.textColors.mediumColors.base.withAlpha(20),
                width: 0.5,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
              gradient: entry.eventType == EventType.exam || entry.eventType == EventType.movie
                  ? LinearGradient(
                      colors: [
                        Color.lerp(entry.color, context.colors.neutralColors.backgroundColors.tile, 0.75)!,
                        context.colors.neutralColors.backgroundColors.tile,
                      ],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      stops: const [0.0, 1.0],
                    )
                  : null,
              color: context.colors.neutralColors.backgroundColors.tile,
            ),
            padding: const EdgeInsets.fromLTRB(LmuSizes.size_4, 4, 4, 0),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /// Farbbalken über die ganze Höhe
                  Padding(
                    padding: const EdgeInsets.all(LmuSizes.size_8),
                    child: Container(
                      width: 2,
                      decoration: BoxDecoration(
                        color: entry.color,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(LmuRadiusSizes.mediumLarge),
                        ),
                      ),
                    ),
                  ),

                  /// Abstand + Inhalt
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, LmuSizes.size_8, LmuSizes.size_8, LmuSizes.size_8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Titelzeile mit Tag daneben
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: LmuText.body(
                                  entry.title,
                                  weight: FontWeight.bold,
                                  maxLines: titleMaxLines,
                                  customOverFlow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: LmuSizes.size_8),
                              Row(
                                children: [_buildTags()],
                              ),
                            ],
                          ),

                          if (showTime) ...[
                            const SizedBox(height: LmuSizes.size_2),
                            LmuText.bodySmall(
                              DateTimeFormatter.formatDateTimeRange(entry.startTime, entry.endTime),
                              color: context.colors.neutralColors.textColors.mediumColors.base,
                              maxLines: timeMaxLines,
                              customOverFlow: TextOverflow.ellipsis,
                            ),
                          ],

                          if (showLocation) ...[
                            const SizedBox(height: LmuSizes.size_2),

                            /// Ort (Adresse + optional Raum)
                            LmuText.bodySmall(
                              entry.location.address,
                              color: context.colors.neutralColors.textColors.mediumColors.base,
                              maxLines: locationMaxLines,
                              customOverFlow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTags() {
    return Wrap(
      children: [
        LmuInTextVisual.text(
          title: entry.eventType.name,
        ),
        if (entry.eventType == EventType.movie) ...[
          const SizedBox(width: LmuSizes.size_2),
          LmuInTextVisual.icon(
            icon: LucideIcons.clapperboard,
          ),
          const SizedBox(width: LmuSizes.size_2),
          LmuInTextVisual.icon(
            icon: LucideIcons.star,
          ),
        ],
        if (entry.location != null && entry.location!.isOnline) ...[
          const SizedBox(width: LmuSizes.size_2),
          LmuInTextVisual.icon(
            icon: LucideIcons.external_link,
          ),
        ],
        if (entry.rule != null && entry.rule!.isRecurring) ...[
          const SizedBox(width: LmuSizes.size_2),
          LmuInTextVisual.icon(
            icon: LucideIcons.repeat,
          ),
        ],
      ],
    );
  }
}

class CalendarCardExperimental extends StatelessWidget {
  const CalendarCardExperimental({
    super.key,
    required this.entry,
    this.fontSizeOverride,
    required this.onTap,
  });

  final CalendarEntry entry;
  final double? fontSizeOverride;
  final void Function() onTap;

  static const double _defaultFontSize = 14.0;

  // Define constant spacing values used in the card
  static const double _verticalTextSpacing = LmuSizes.size_2;
  static const double _verticalPadding = LmuSizes.size_8;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double currentHeight = constraints.maxHeight;
        final double currentWidth = constraints.maxWidth;
        final double screenWidth = MediaQuery.of(context).size.width;

        final double baseFontSize = fontSizeOverride ?? _defaultFontSize;
        final bool wrapTags = currentWidth < screenWidth * 0.5;

        // --- DYNAMIC HEIGHT CALCULATION ---
        double availableHeight = currentHeight - (_verticalPadding * 2); // Subtract top and bottom
        double availableWidth = currentWidth - (32); // Subtract left and right

        // Set max lines based on remaining height
        const double heightOf15Min = (15 / 60) * fixedHeightPerHour;
        final int titleMaxLines = currentHeight >= heightOf15Min * 4 ? 2 : 1;
        final int timeMaxLines = currentHeight >= heightOf15Min * 6 ? 2 : 1;
        final int locationMaxLines = currentHeight >= heightOf15Min * 5 ? 2 : 1;

        // Calculate title and tag height
        final double titleHeight = _calculateTextHeight2(
          text: entry.title,
          style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: baseFontSize),
          context: context,
          maxWidth: availableWidth,
          maxLines: titleMaxLines,
        );

        final double tagsHeight = _calculateTextHeight2(
          text: entry.eventType.name,
          style: theme.textTheme.bodyMedium!.copyWith(fontSize: 12),
          context: context,
          maxWidth: availableWidth,
          maxLines: wrapTags ? 1 : 2,
        );

        final double titleAndTagsHeight = wrapTags
            ? titleHeight + tagsHeight + _verticalTextSpacing
            : titleHeight; // Simplified for this example, a more complex calculation might be needed
        availableHeight -= titleAndTagsHeight;

        // Check if there is enough space for the location
        final double locationHeight = _calculateTextHeight(
          text: entry.location.address,
          style: theme.textTheme.bodySmall!,
          context: context,
        );
        final bool showLocation = availableHeight >= locationHeight;

        // If location is shown, subtract its height and vertical spacing
        if (showLocation) {
          availableHeight -= locationHeight + _verticalTextSpacing;
        }

        // Check if there is enough space for the time
        final double timeHeight = _calculateTextHeight(
          text: DateTimeFormatter.formatDateTimeRange(entry.startTime, entry.endTime),
          style: theme.textTheme.bodySmall!,
          context: context,
        );
        final bool showTime = availableHeight >= timeHeight;

        // If time is shown, subtract its height and vertical spacing
        if (showTime) {
          availableHeight -= timeHeight + _verticalTextSpacing;
        }

        // --- END DYNAMIC HEIGHT CALCULATION ---

        return GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.all(LmuSizes.size_2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: context.colors.neutralColors.textColors.mediumColors.base.withAlpha(20),
                width: 0.5,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
              gradient: entry.eventType == EventType.exam || entry.eventType == EventType.movie
                  ? LinearGradient(
                      colors: [
                        Color.lerp(entry.color, context.colors.neutralColors.backgroundColors.tile, 0.75)!,
                        context.colors.neutralColors.backgroundColors.tile,
                      ],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      stops: const [0.0, 1.0],
                    )
                  : null,
              color: context.colors.neutralColors.backgroundColors.tile,
            ),
            padding: const EdgeInsets.fromLTRB(LmuSizes.size_4, 4, 4, 0),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /// Farbbalken über die ganze Höhe
                  Padding(
                    padding: const EdgeInsets.all(LmuSizes.size_8),
                    child: Container(
                      width: 2,
                      decoration: BoxDecoration(
                        color: entry.color,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(LmuRadiusSizes.mediumLarge),
                        ),
                      ),
                    ),
                  ),

                  /// Abstand + Inhalt
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, LmuSizes.size_8, LmuSizes.size_8, LmuSizes.size_8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Titelzeile mit Tag daneben oder darunter
                          wrapTags
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    LmuText.body(
                                      entry.title,
                                      weight: FontWeight.bold,
                                      maxLines: titleMaxLines,
                                      customOverFlow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: _verticalTextSpacing),
                                    _buildTags(),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: LmuText.body(
                                        entry.title,
                                        weight: FontWeight.bold,
                                        maxLines: titleMaxLines,
                                        customOverFlow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: LmuSizes.size_8),
                                    _buildTags(),
                                  ],
                                ),

                          if (showTime) ...[
                            const SizedBox(height: _verticalTextSpacing),
                            LmuText.bodySmall(
                              DateTimeFormatter.formatDateTimeRange(entry.startTime, entry.endTime),
                              color: context.colors.neutralColors.textColors.mediumColors.base,
                              maxLines: timeMaxLines,
                              customOverFlow: TextOverflow.ellipsis,
                            ),
                          ],

                          if (showLocation) ...[
                            const SizedBox(height: _verticalTextSpacing),

                            /// Ort (Adresse + optional Raum)
                            LmuText.bodySmall(
                              entry.location.address,
                              color: context.colors.neutralColors.textColors.mediumColors.base,
                              maxLines: locationMaxLines,
                              customOverFlow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTags() {
    return Row(
      children: [
        LmuInTextVisual.text(
          title: entry.eventType.name,
        ),
        if (entry.eventType == EventType.movie) ...[
          const SizedBox(width: LmuSizes.size_2),
          LmuInTextVisual.icon(
            icon: LucideIcons.clapperboard,
          ),
          const SizedBox(width: LmuSizes.size_2),
          LmuInTextVisual.icon(
            icon: LucideIcons.star,
          ),
        ],
        if (entry.location != null && entry.location!.isOnline) ...[
          const SizedBox(width: LmuSizes.size_2),
          LmuInTextVisual.icon(
            icon: LucideIcons.external_link,
          ),
        ],
        if (entry.rule != null && entry.rule!.isRecurring) ...[
          const SizedBox(width: LmuSizes.size_2),
          LmuInTextVisual.icon(
            icon: LucideIcons.repeat,
          ),
        ],
      ],
    );
  }

  // Helper method to calculate the height of a text element
  double _calculateTextHeight({
    required String text,
    required TextStyle style,
    required BuildContext context,
    int? maxLines,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: double.infinity);
    return textPainter.size.height;
  }

  double _calculateTextHeight2({
    required String text,
    required TextStyle style,
    required BuildContext context,
    required double maxWidth,
    int? maxLines,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);
    return textPainter.size.height;
  }
}
