import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../../domain/model/calendar_entry.dart';
import '../../domain/model/event_type.dart';
import '../../domain/model/helper/date_time_formatter.dart';
import '../constants.dart';

class CalendarCard extends StatelessWidget {
  /// The default constructor for use in **unbounded-width** contexts (e.g., Column, Row, ListView, vertical scroll views, ...).
  /// Meaning the parent widget does not impose any width constraints the card uses as much space as it needs.
  ///
  /// This card will **shrink-wrap** its content, taking up only as much vertical (and horizontal) space as needed.
  const CalendarCard({
    super.key,
    required this.entry,
    this.fontSizeOverride,
    this.noBorder = true,
    required this.onTap,
  }) : _isUnbounded = true;

  /// A constructor for use in **bounded-width & -height** contexts.
  /// Meaning, the parent widget needs to give constrains in width and height, or else it will cause overflow!
  ///
  /// This card will expand to fill the width provided by its parent and the layout will adjust to the given width.
  const CalendarCard.bounded({
    super.key,
    required this.entry,
    this.fontSizeOverride,
    required this.onTap,
    this.noBorder = false,
  }) : _isUnbounded = false;

  final CalendarEntry entry;
  final double? fontSizeOverride;
  final void Function() onTap;
  final bool _isUnbounded;
  final bool noBorder;

  static const double _verticalTextSpacing = LmuSizes.size_2;

  @override
  Widget build(BuildContext context) {
    final Widget cardContent = _isUnbounded ? _buildUnboundedLayout(context) : _buildBoundedLayout(context);

    // The GestureDetector is shared between both layouts.
    return GestureDetector(
      onTap: onTap,
      child: _isUnbounded ? IntrinsicWidth(child: cardContent) : cardContent,
    );
  }

  Widget _buildBoundedLayout(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double currentHeight = constraints.maxHeight;
        final double currentWidth = constraints.maxWidth;
        final double screenWidth = MediaQuery.of(context).size.width;

        // Dynamic calculations based on available space
        final bool wrapTags = currentWidth < screenWidth * 0.4;
        const double heightOf15Min = (15 / 60) * fixedHeightPerHour;
        final int titleMaxLines = currentHeight >= heightOf15Min * 4 ? 2 : 1;
        final int timeMaxLines = currentHeight >= heightOf15Min * 6 ? 2 : 1;
        final int locationMaxLines = currentHeight >= heightOf15Min * 5 ? 2 : 1;

        return ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(LmuSizes.size_8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_2),
            child: Container(
              decoration: _getCardStyle(context, entry, noBorder),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CalendarCardVerticalColorBar(
                    color: entry.color ?? entry.eventType.defaultColor,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, LmuSizes.size_8, LmuSizes.size_8, LmuSizes.size_8),
                      child: Wrap(
                        children: [
                          CalendarCardTitleWithTags(
                            entry: entry,
                            titleMaxLines: titleMaxLines,
                            verticalTextSpacing: _verticalTextSpacing,
                            wrapTags: wrapTags,
                          ),
                          CalendarCardTimeAndLocationColumn(
                            startTime: entry.startTime,
                            endTime: entry.endTime,
                            location: entry.location?.address ?? entry.onlineLink ?? '',
                            timeMaxLines: timeMaxLines,
                            locationMaxLines: locationMaxLines,
                            verticalTextSpacing: _verticalTextSpacing,
                          ),
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

  Widget _buildUnboundedLayout(BuildContext context) {
    return Container(
      decoration: _getCardStyle(context, entry, noBorder),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CalendarCardVerticalColorBar(
              color: entry.color ?? entry.eventType.defaultColor,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, LmuSizes.size_8, LmuSizes.size_8, LmuSizes.size_8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Titelzeile mit Tag daneben
                    CalendarCardTitleWithTags(
                      entry: entry,
                      verticalTextSpacing: _verticalTextSpacing,
                      titleMaxLines: 2,
                      wrapTags: false,
                    ),
                    CalendarCardTimeAndLocationColumn(
                      startTime: entry.startTime,
                      endTime: entry.endTime,
                      timeMaxLines: 2,
                      locationMaxLines: 2,
                      location: entry.location?.address ?? entry.onlineLink ?? '',
                      verticalTextSpacing: _verticalTextSpacing,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

BoxDecoration _getCardStyle(BuildContext context, CalendarEntry entry, bool noBorder) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(LmuSizes.size_8),
    border: noBorder
        ? Border.all(
            color: Colors.transparent,
            width: 0.5,
            strokeAlign: BorderSide.strokeAlignInside,
          )
        : Border.all(
            color: context.colors.neutralColors.textColors.mediumColors.base.withAlpha(40),
            width: 0.5,
            strokeAlign: BorderSide.strokeAlignInside,
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
  );
}

class CalendarCardVerticalColorBar extends StatelessWidget {
  const CalendarCardVerticalColorBar({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(LmuSizes.size_8),
      child: Container(
        width: 2,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(LmuRadiusSizes.mediumLarge),
          ),
        ),
      ),
    );
  }
}

class CalendarCardTitleWithTags extends StatelessWidget {
  const CalendarCardTitleWithTags({
    super.key,
    required this.entry,
    this.titleMaxLines,
    required this.verticalTextSpacing,
    this.wrapTags = false,
  });

  final CalendarEntry entry;
  final int? titleMaxLines;
  final double verticalTextSpacing;
  final bool wrapTags;

  @override
  Widget build(BuildContext context) {
    return wrapTags
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LmuText.bodySmall(
                entry.title,
                weight: FontWeight.bold,
                maxLines: titleMaxLines,
                customOverFlow: TextOverflow.ellipsis,
              ),
              SizedBox(height: verticalTextSpacing),
              _buildTags(wrapTags),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: LmuText.bodySmall(
                  entry.title,
                  weight: FontWeight.bold,
                  maxLines: titleMaxLines,
                  customOverFlow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: LmuSizes.size_8),
              _buildTags(wrapTags),
            ],
          );
  }

  Widget _buildTags(bool wrapTags) {
    final tagsContent = [
      LmuInTextVisual.text(title: entry.eventType.name),
      if (entry.eventType == EventType.movie) ...[
        LmuInTextVisual.icon(icon: LucideIcons.clapperboard),
        LmuInTextVisual.icon(icon: LucideIcons.star),
      ],
      if (entry.onlineLink != null && entry.eventType != EventType.movie)
        LmuInTextVisual.icon(icon: LucideIcons.external_link),
      if (entry.rule != null && entry.rule!.isRecurring) LmuInTextVisual.icon(icon: LucideIcons.repeat),
    ];

    return wrapTags
        ? Wrap(
            spacing: LmuSizes.size_2,
            runSpacing: LmuSizes.size_2,
            children: tagsContent,
          )
        : Row(
            spacing: LmuSizes.size_2,
            mainAxisSize: MainAxisSize.min,
            children: tagsContent,
          );
  }
}

class CalendarCardTimeAndLocationColumn extends StatelessWidget {
  const CalendarCardTimeAndLocationColumn({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.location,
    this.timeMaxLines,
    this.locationMaxLines,
    required this.verticalTextSpacing,
  });

  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final int? timeMaxLines;
  final int? locationMaxLines;
  final double verticalTextSpacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: verticalTextSpacing),
        // Time
        LmuText.bodySmall(
          DateTimeFormatter.formatDateTimeRange(startTime, endTime),
          color: context.colors.neutralColors.textColors.mediumColors.base,
          maxLines: timeMaxLines,
          customOverFlow: TextOverflow.ellipsis,
        ),
        SizedBox(height: verticalTextSpacing),

        /// Location
        LmuText.bodySmall(
          location,
          color: context.colors.neutralColors.textColors.mediumColors.base,
          maxLines: locationMaxLines,
          customOverFlow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
