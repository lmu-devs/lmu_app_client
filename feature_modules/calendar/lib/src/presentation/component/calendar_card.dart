import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../../domain/model/calendar_event.dart';

enum CalendarType {
  lecture,
  meeting,
  event,
  exam,
}

class CalendarCard extends StatelessWidget {
  const CalendarCard({
    super.key,
    required this.event,
    required this.onTap,
    this.isHalfWidth = false,
  });

  final CalendarEvent event;
  final void Function() onTap;
  final bool isHalfWidth;

  @override
  Widget build(BuildContext context) {
    final cardWidth = isHalfWidth ? (MediaQuery.of(context).size.width - 40) / 2 : double.infinity;

    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: cardWidth,
        margin: const EdgeInsets.only(bottom: LmuSizes.size_12),
        decoration: BoxDecoration(
          color: context.colors.neutralColors.backgroundColors.tile,
          borderRadius: BorderRadius.circular(LmuRadiusSizes.mediumLarge),
          border: Border.all(
              color: event.type == CalendarType.exam ? event.color : context.colors.neutralColors.backgroundColors.tile,
              width: 2,
              strokeAlign: BorderSide.strokeAlignInside),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Farbbalken über die ganze Höhe
              event.type != CalendarType.exam
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: LmuSizes.size_16, top: LmuSizes.size_16, bottom: LmuSizes.size_16),
                      child: Container(
                        width: 4,
                        decoration: BoxDecoration(
                          color: event.color,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(LmuRadiusSizes.mediumLarge),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),

              /// Abstand + Inhalt
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(LmuSizes.size_16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Titelzeile mit Tag daneben
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// Titel (maximaler Platz, aber nicht unendlich)
                          Flexible(
                            fit: FlexFit.loose,
                            child: LmuText.h3(
                              event.title,
                              maxLines: 1,
                              customOverFlow: TextOverflow.ellipsis,
                            ),
                          ),

                          const SizedBox(width: LmuSizes.size_8),

                          /// Tag (immer sichtbar, direkt nach dem Titel)
                          LmuInTextVisual.text(
                            title: _calendarTypeToText(event.type),
                          ),
                        ],
                      ),

                      const SizedBox(height: LmuSizes.size_4),

                      /// Zeit
                      LmuText.bodySmall(
                        _formatDateTimeRange(event.startDate, event.endDate),
                        color: context.colors.neutralColors.textColors.mediumColors.base,
                      ),

                      const SizedBox(height: LmuSizes.size_4),

                      /// Ort (Adresse + optional Raum)
                      LmuText.bodySmall(
                        event.location.address,
                        color: context.colors.neutralColors.textColors.mediumColors.base,
                        maxLines: 2,
                        customOverFlow: TextOverflow.ellipsis,
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
  }

  String _calendarTypeToText(CalendarType type) {
    switch (type) {
      case CalendarType.lecture:
        return 'Vorlesung';
      case CalendarType.meeting:
        return 'Meeting';
      case CalendarType.event:
        return 'Event';
      case CalendarType.exam:
        return 'Klausur';
    }
  }

  String _formatDateTimeRange(DateTime start, DateTime end) {
    final startTime = '${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}';
    final endTime = '${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}';
    return '$startTime - $endTime';
  }
}
