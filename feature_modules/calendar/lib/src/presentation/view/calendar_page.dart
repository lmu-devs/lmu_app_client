import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/model/CalendarViewMode.dart';
import '../component/calendar_card.dart';
import '../component/loading_components/calendar_card_loading.dart';
import '../viewmodel/calendar_page_driver.dart';

class CalendarPage extends DrivableWidget<CalendarPageDriver> {
  CalendarPage({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return LmuScaffold(
  //     appBar: LmuAppBarData(
  //       largeTitle: driver.largeTitle,
  //       leadingAction: LeadingAction.back,
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
  //       child: LmuPageAnimationWrapper(
  //         child: Align(
  //           key: ValueKey("calendar_page_${driver.isLoading}"),
  //           alignment: Alignment.topCenter,
  //           child: SizedBox(
  //             height: 500,
  //             child: content,
  //           ),
  //         ),
  //       ),
  //     ),
  //     floatingActionButton: FloatingActionButton.extended(
  //       label: const Text('Add Event'),
  //       icon: const Icon(Icons.add),
  //       onPressed: () => driver.onCalendarCardPressed(),
  //     ),
  //   );
  // }

  // Widget get content {
  //   if (driver.isLoading) return const LmuSkeleton(child: Text('loading calendar events...'));

  //   return ListView.builder(
  //     itemCount: driver.events.length,
  //     itemBuilder: (context, index) {
  //       final event = driver.events[index];
  //       return CalendarCard(
  //         key: Key("calendar_event_${event.id}"),
  //         event: event,
  //         onTap: () => driver.onEventTap(event, context),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.largeTitle,
        leadingAction: LeadingAction.back,
      ),
      body: SizedBox(
        height: 700,
        child: Column(
          children: [
            _buildViewSelector(),
            // if (driver.viewMode == CalendarViewMode.day) _buildDateSelector(),
            if (driver.viewMode == CalendarViewMode.day) _buildWeekPicker(),
            Expanded(child: _buildEventList()),
          ],
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
        ChoiceChip(
          label: const Text('List View'),
          selected: driver.viewMode == CalendarViewMode.list,
          onSelected: (_) => driver.onViewModeChanged(CalendarViewMode.list),
        ),
        const SizedBox(width: 8),
        ChoiceChip(
          label: const Text('Day View'),
          selected: driver.viewMode == CalendarViewMode.day,
          onSelected: (_) => driver.onViewModeChanged(CalendarViewMode.day),
        ),
      ],
    );
  }

  Widget _buildDateSelector() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CalendarDatePicker(
        initialDate: driver.selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        onDateChanged: driver.onDateSelected,
      ),
    );
  }

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
        return CalendarCard(
          key: Key("calendar_event_${event.id}"),
          event: event,
          onTap: () => driver.onEventTap(event, context),
        );
      },
    );
  }

  Widget _buildWeekPicker() {
    final startOfWeek = driver.selectedDate.subtract(
      Duration(days: driver.selectedDate.weekday - 1),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(7, (index) {
          final date = startOfWeek.add(Duration(days: index));
          final isSelected = date.day == driver.selectedDate.day &&
              date.month == driver.selectedDate.month &&
              date.year == driver.selectedDate.year;

          return GestureDetector(
            onTap: () => driver.onDateSelected(date),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blueAccent : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'][index],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    '${date.day}',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  WidgetDriverProvider<CalendarPageDriver> get driverProvider => $CalendarPageDriverProvider();
}
