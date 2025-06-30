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
                title: (event.type.name),
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
              DateRangeDisplay(
                start: event.startDate,
                end: event.endDate,
                allDay: event.allDay,
              ),
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
