import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../domain/model/calendar_entry.dart';
import '../../domain/model/helper/date_time_formatter.dart';

// --- Calendar Card Widget ---
class CalendarCard extends StatelessWidget {
  final CalendarEntry entry;

  const CalendarCard({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double currentCardHeight = constraints.maxHeight;
        final double currentCardWidth = constraints.maxWidth;

        // Simplified font size logic for a fixed pixelsPerHour
        final double baseFontSize = 14.0;
        final double scaledTitleFontSize = math.max(8.0, baseFontSize * (currentCardHeight / 60));
        final double scaledBodyFontSize = scaledTitleFontSize * 0.8;
        final double scaledDescriptionFontSize = scaledTitleFontSize * 0.7;

        bool showTimeAndLocation = currentCardWidth > 80 && currentCardHeight > 30;
        bool showDescription = currentCardWidth > 120 && currentCardHeight > 50;

        return Container(
          margin: const EdgeInsets.all(1.0), // Small margin for visual separation
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: entry.color.withOpacity(0.8),
            border: Border.all(color: entry.color, width: 0.5),
          ),
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                entry.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleSmall?.copyWith(
                      fontSize: scaledTitleFontSize,
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ) ??
                    const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold), // Fallback
                textScaler: TextScaler.linear(1.0),
              ),
              if (showTimeAndLocation)
                Text(
                  '${DateTimeFormatter.formatTimeForLocale(entry.startTime)} - ${DateTimeFormatter.formatTimeForLocale(entry.endTime)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodySmall?.copyWith(
                        fontSize: scaledBodyFontSize,
                        color: theme.colorScheme.onPrimaryContainer,
                      ) ??
                      const TextStyle(fontSize: 12.0), // Fallback
                  textScaler: TextScaler.linear(1.0),
                ),
              Text(
                entry.location.address, // Still using ! assuming if (null != null) is false
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodySmall?.copyWith(
                      fontSize: scaledBodyFontSize,
                      color: theme.colorScheme.onPrimaryContainer,
                    ) ??
                    const TextStyle(fontSize: 12.0), // Fallback
                textScaler: TextScaler.linear(1.0),
              ),
              if (showDescription && entry.description != null)
                Expanded(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Text(
                      entry.description!,
                      style: textTheme.bodySmall?.copyWith(
                            fontSize: scaledDescriptionFontSize,
                            color: theme.colorScheme.onPrimaryContainer,
                          ) ??
                          const TextStyle(fontSize: 10.0), // Fallback
                      textScaler: TextScaler.linear(1.0),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
