import 'dart:io';

import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:widget_driver/widget_driver.dart';

import '../component/calendar_entry_point.dart';
import '../component/courses_entry_point.dart';
import '../component/grades_entry_point.dart';
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
              id: "12680165",
              title: "Raphael Wennmacher",
              description: "Computer Science Student",
              onTap: () {},
            ),
            const SizedBox(height: LmuSizes.size_32),
            LmuButton(
              title: Platform.isIOS ? "Add to Apple Wallet" : "Add to Google Wallet",
              action: ButtonAction.contrast,
              size: ButtonSize.large,
              leadingWidget: Image.asset(
                Platform.isIOS ? 'assets/apple_wallet.png' : 'assets/google_wallet.png',
                package: "studies",
                width: LmuIconSizes.medium,
                height: LmuIconSizes.medium,
              ),
              onTap: () => LmuToast.show(context: context, message: "Added to Wallet", type: ToastType.success),
            ),
            const CalenderEntryPoint(),
            const SizedBox(height: LmuSizes.size_32),
            const GradesEntryPoint(),
            const SizedBox(height: LmuSizes.size_32),
            const CoursesEntryPoint(),
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
