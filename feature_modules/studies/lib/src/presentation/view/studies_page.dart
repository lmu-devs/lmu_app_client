import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/core_services.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../component/calendar_entry_point.dart';
import '../component/lectures_entry_point.dart';
import '../component/people_entry_point.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: Column(
          children: [
            const SizedBox(height: LmuSizes.size_16),
            StudentId(
              id: "123456",
              title: "John Doe",
              description: "Computer Science Student",
              onTap: () {
                GetIt.I<PushNotificationsClient>().showNotification(
                  id: 1,
                  title: 'Deadline Rückmeldung',
                  body: 'Verpasse nicht rechtzeitig den Semesterbeitrag vor dem 14.07 zu zahlen',
                  payload: {'destination': '/home/roomfinder/details?building-id=bt2971'},
                );
              },
            ),
            const SizedBox(height: LmuSizes.size_32),
            const CelanderEntryPoint(),
            const SizedBox(height: LmuSizes.size_32),
            const LecturesEntryPoint(),
            const SizedBox(height: LmuSizes.size_32),
            const PeopleEntryPoint(),
            const SizedBox(height: LmuSizes.size_96),
          ],
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<StudiesPageDriver> get driverProvider => $StudiesPageDriverProvider();
}
