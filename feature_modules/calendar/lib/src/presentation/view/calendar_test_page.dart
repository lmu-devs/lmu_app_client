import 'package:flutter/material.dart';
// import 'package:widget_driver/widget_driver.dart';

// TestPage for Testing-purposes,
//currently static widget, but could implement drivable widget in the future

class CalendarTestPage extends StatelessWidget
// extends DrivableWidget<CalendarTestPageDriver>
{
  const CalendarTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text('Test Calendar Page'));
  }

  // @override
  // WidgetDriverProvider<CalendarTestPageDriver> get driverProvider => $CalendarTestPageDriverProvider();
}
