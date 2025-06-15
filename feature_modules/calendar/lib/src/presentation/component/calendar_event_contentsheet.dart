import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';

import '../../domain/model/calendar_event.dart';
import 'calendar_card.dart';

void openCalendarEventContentSheet(
  BuildContext context, {
  required CalendarEvent event,
}) {
  LmuBottomSheet.show(
    context,
    content: CalendarEventBottomSheet(event: event),
  );
}

class CalendarEventBottomSheet extends StatelessWidget {
  final CalendarEvent event;

  const CalendarEventBottomSheet({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final startDate = LmuText(event.startDate.toString());
    final endDate = LmuText(event.endDate.toString());
    final location = LmuText(event.location.address);
    final description = event.description != null ? LmuText.body(event.description!) : const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(LmuSizes.size_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LmuInTextVisual.text(
                title: _calendarTypeToText(event.type),
                size: InTextVisualSize.large,
              ),
              const SizedBox(height: LmuSizes.size_8),
              Row(
                children: [
                  LmuText.h1(event.title),
                  const SizedBox(width: LmuSizes.size_8),
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: event.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_8),
              startDate,
              const SizedBox(height: LmuSizes.size_8),
              endDate,
              const SizedBox(height: LmuSizes.size_8),
              location,
              const SizedBox(height: LmuSizes.size_16),
              description,
            ],
          ),
        ),
      ],
    );
  }
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
