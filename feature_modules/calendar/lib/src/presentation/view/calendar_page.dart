import 'package:core/api.dart';
import 'package:core/components.dart';
import 'package:core/utils.dart';
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
        onPressed: driver.onAddEventPressed,
      ),
    );
  }

  Widget _buildViewSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LmuDateLabel(date: DateTime.now()), // today
        const SizedBox(height: LmuSizes.size_16),
      ],
    );
  }

  // Widget _buildDateSelector() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: CalendarDatePicker(
  //       initialDate: driver.selectedDate,
  //       firstDate: DateTime(2020),
  //       lastDate: DateTime(2030),
  //       onDateChanged: driver.onDateSelected,
  //     ),
  //   );
  // }

  Widget _buildEventList() {
    if (driver.isLoadingEvents) {
      return const Column(
        children: [
          CalendarCardLoading(),
          CalendarCardLoading(),
          CalendarCardLoading(),
        ],
      );
    }

    if (driver.calendarEntries == null || driver.calendarEntries!.isEmpty) {
      return const Center(child: Text('No events found.'));
    }

    return ListView.builder(
      itemCount: driver.calendarEntries!.length,
      itemBuilder: (context, index) {
        final event = driver.calendarEntries![index];
        return CalendarEntryCard(
          key: Key("calendar_event_${event.id}"),
          event: event,
          onTap: () => driver.onEventTap(event, context),
        );
      },
    );
  }

  Widget _buildWeekPicker() {
    final startOfWeek = DateTime.now().subtract(
      Duration(days: DateTime.now().weekday - 1),
    );
    driver.selectedDate.dateTimeFromSingleDayRange;
    startOfWeek.subtract(
      Duration(days: startOfWeek.weekday - 1),
    );

    return WeekPicker(
        selectedDate: driver.selectedDate.dateTimeFromSingleDayRange,
        onDateSelected: (date) => driver.onDateSelected(date));

    // return Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     children: List.generate(7, (index) {
    //       final date = startOfWeek.add(Duration(days: index));
    //       final isSelected = date.day == driver.selectedDate.dateTimeFromSingleDayRange.day &&
    //           date.month == driver.selectedDate.dateTimeFromSingleDayRange.month &&
    //           date.year == driver.selectedDate.dateTimeFromSingleDayRange.year;

    //       return GestureDetector(
    //         onTap: () => driver.onDateSelected(date),
    //         child: Container(
    //           padding: const EdgeInsets.all(8),
    //           decoration: BoxDecoration(
    //             color: isSelected ? Colors.blueAccent : Colors.transparent,
    //             borderRadius: BorderRadius.circular(8),
    //           ),
    //           child: Column(
    //             children: [
    //               Text(
    //                 ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'][index],
    //                 style: TextStyle(
    //                   fontWeight: FontWeight.bold,
    //                   color: isSelected ? Colors.white : Colors.black,
    //                 ),
    //               ),
    //               Text(
    //                 '${date.day}',
    //                 style: TextStyle(
    //                   color: isSelected ? Colors.white : Colors.black,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     }),
    //   ),
    // );
  }

  @override
  WidgetDriverProvider<CalendarPageDriver> get driverProvider => $CalendarPageDriverProvider();
}
