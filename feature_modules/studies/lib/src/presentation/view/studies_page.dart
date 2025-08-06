import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:widget_driver/widget_driver.dart';

import '../component/calendar_entry_point.dart';
import '../component/lectures_entry_point.dart';
import '../component/people_entry_point.dart';
import '../component/student_id/holographic_card.dart';
import '../viewmodel/studies_page_driver.dart';

class StudiesPage extends DrivableWidget<StudiesPageDriver> {
  StudiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.pageTitle,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: Column(
          children: [
            SizedBox(height: LmuSizes.size_32),
            HolographicCard(),
            SizedBox(height: LmuSizes.size_32),
            SizedBox(height: LmuSizes.size_32),
            CalenderEntryPoint(),
            SizedBox(height: LmuSizes.size_32),
            LecturesEntryPoint(),
            SizedBox(height: LmuSizes.size_32),
            PeopleEntryPoint(),
            SizedBox(height: LmuSizes.size_96),
          ],
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<StudiesPageDriver> get driverProvider => $StudiesPageDriverProvider();
}
