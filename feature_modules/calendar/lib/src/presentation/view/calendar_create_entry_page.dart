// calendar_create_entry_page.dart

import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../viewmodel/calendar_create_entry_page_driver.dart';

class CalendarCreateEntryPage extends DrivableWidget<CalendarCreateEntryPageDriver> {
  CalendarCreateEntryPage({super.key});

  // Just a PlaceHolder will be finished soon (this week?)!

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(driver.largeTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(driver.largeTitle, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
            LmuInputField(
              controller: driver.titleController,
              hintText: 'Event Title',
              isMultiline: false,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<CalendarCreateEntryPageDriver> get driverProvider => $CalendarCreateEntryPageDriverProvider();
}
