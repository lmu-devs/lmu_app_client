import 'package:core/api.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/model/calendar_event.dart';
import '../component/calendar_card.dart';
import '../component/calendar_event_contentsheet.dart';
import '../component/date_lable.dart';
import '../viewmodel/calendar_page_driver.dart';

class CalendarPage extends DrivableWidget<CalendarPageDriver> {
  CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    CalendarEvent event = CalendarEvent(
      id: 'event_123',
      title: 'UX Workshop',
      type: CalendarType.event,
      color: Colors.blue,
      startDate: DateTime(2023, 10, 15),
      endDate: DateTime(2023, 10, 15),
      location: const LocationModel(address: 'Ludwigstraße 1, München', latitude: 48.1500, longitude: 11.5800),
      description: 'A practical workshop on UX patterns and psychology.',
    );
    CalendarEvent event2 = CalendarEvent(
      id: 'event_456',
      title: 'Flutter Workshop',
      type: CalendarType.exam,
      color: Colors.green,
      startDate: DateTime(2023, 10, 15),
      endDate: DateTime(2023, 10, 15),
      location: const LocationModel(address: 'Ludwigstraße 1, München', latitude: 48.1500, longitude: 11.5800),
      description: 'A  comprehensive workshop on Flutter development.',
    );

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.largeTitle,
        leadingAction: LeadingAction.back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: LmuPageAnimationWrapper(
          child: Align(
            key: ValueKey("calendar_page_${driver.isLoading}"),
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                CalendarCard(
                  event: event,
                  onTap: () {
                    openCalendarEventContentSheet(context, event: event);
                  },
                ),
                CalendarCard(
                  event: event2,
                  onTap: () {
                    openCalendarEventContentSheet(context, event: event2);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add Event'),
        icon: const Icon(Icons.add),
        onPressed: () => driver.onCalendarCardPressed(),
      ),
    );
  }

  Widget get content {
    if (driver.isLoading) return const SizedBox.shrink(); // replace with skeleton loading

    return Column(
      children: [
        LmuDateLabel(date: DateTime.now()), // today
        const SizedBox(height: LmuSizes.size_16),
      ],
    );
  }

  @override
  WidgetDriverProvider<CalendarPageDriver> get driverProvider => $CalendarPageDriverProvider();
}
