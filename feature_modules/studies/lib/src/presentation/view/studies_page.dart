import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:widget_driver/widget_driver.dart';

import '../component/courses_entry_point.dart';
import '../component/grades_entry_point.dart';
import '../component/student_id.dart';
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
            const SizedBox(height: LmuSizes.size_16),
            const StudentId(),
            const SizedBox(height: LmuSizes.size_32),
            const GradesEntryPoint(),
            const SizedBox(height: LmuSizes.size_32),
            const CoursesEntryPoint(),
            const SizedBox(height: LmuSizes.size_96),
          ],
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<StudiesPageDriver> get driverProvider => $StudiesPageDriverProvider();
}
