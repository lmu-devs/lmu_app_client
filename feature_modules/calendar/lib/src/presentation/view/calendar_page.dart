import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../component/calendar_card.dart';
import '../viewmodel/calendar_page_driver.dart';

class CalendarPage extends DrivableWidget<CalendarPageDriver> {
  CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: content,
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
        const SizedBox(height: LmuSizes.size_16),
        CalendarCard(
          id: driver.calendarId,
          title: driver.title,
          description: driver.description,
          onTap: driver.onCalendarCardPressed,
        ),
        const SizedBox(height: LmuSizes.size_32),
      ],
    );
  }

  @override
  WidgetDriverProvider<CalendarPageDriver> get driverProvider => $CalendarPageDriverProvider();
}
