import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';

import '../../domain/model/calendar_entry.dart';
import '../component/date_range.dart';

void openCalendarEventContentSheet(
  BuildContext context, {
  required CalendarEntry event,
}) {
  LmuBottomSheet.show(
    context,
    content: CalendarEventBottomSheet(event: event),
  );
}

class CalendarEventBottomSheet extends StatelessWidget {
  const CalendarEventBottomSheet({
    super.key,
    required this.event,
  });

  final CalendarEntry event;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(LmuSizes.size_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LmuInTextVisual.text(
                title: (event.eventType.name),
                size: InTextVisualSize.large,
              ),
              const SizedBox(height: LmuSizes.size_8),
              Row(
                children: [
                  LmuText.h1(event.title),
                  const SizedBox(width: LmuSizes.size_8),
                  Container(
                    width: LmuSizes.size_8,
                    height: LmuSizes.size_16,
                    decoration: BoxDecoration(
                      color: event.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_8),
              DateRangeDisplay(
                start: event.startTime,
                end: event.endTime,
                allDay: event.allDay,
              ),
              const SizedBox(height: LmuSizes.size_8),
              LmuText(event.location.address),
              const SizedBox(height: LmuSizes.size_16),
              event.description != null ? LmuText.body(event.description!) : const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}
