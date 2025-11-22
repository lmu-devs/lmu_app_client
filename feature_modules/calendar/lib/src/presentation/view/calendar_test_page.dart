import 'package:flutter/material.dart';

import 'calendar_search_page.dart';
// import 'package:widget_driver/widget_driver.dart';

// TestPage for Testing-purposes, will be removed before deployment!!
//currently static widget, but could implement drivable widget in the future

class CalendarTestPage extends StatelessWidget
// extends DrivableWidget<CalendarTestPageDriver>
{
  const CalendarTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            // Text('Test Calendar Page')
            CalendarSearchPage());
  }

  // @override
  // WidgetDriverProvider<CalendarTestPageDriver> get driverProvider => $CalendarTestPageDriverProvider();
}
