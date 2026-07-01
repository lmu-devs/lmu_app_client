import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:widget_driver/widget_driver.dart';

import '../component/grade_form_body.dart';
import '../viewmodel/grade_addition_page_driver.dart';

class GradeAdditionPage extends DrivableWidget<GradeAdditionPageDriver> {
  GradeAdditionPage({super.key});

  static void show(BuildContext context) {
    LmuBottomSheet.showExtended(
      context,
      content: GradeAdditionPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      customScrollController: context.modalScrollController,
      isBottomSheet: true,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(LmuSizes.size_16),
          child: LmuButton(
            title: driver.addButtonTitle,
            size: ButtonSize.large,
            showFullWidth: true,
            state: driver.isAddButtonEnabled ? ButtonState.enabled : ButtonState.disabled,
            onTap: () {
              driver.onAddGradePressed();
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      appBar: LmuAppBarData(
        largeTitle: driver.largeTitle,
        leadingAction: LeadingAction.close,
      ),
      body: GradeFormBody(
        selectedGradeSemester: driver.selectedGradeSemester,
        availableSemesters: driver.availableSemesters,
        onGradeSemesterSelected: driver.onGradeSemesterSelected,
        nameController: driver.nameController,
        onNameChanged: driver.onNameChanged,
        ectsController: driver.ectsController,
        onEctsChanged: driver.onEctsChanged,
        sliderIndex: driver.sliderIndex,
        sliderGradeValue: driver.sliderGradeValue,
        noGradeReceived: driver.noGradeReceived,
        onSliderIndexChanged: driver.onSliderIndexChanged,
        onNoGradeReceivedChanged: driver.onNoGradeReceivedChanged,
      ),
    );
  }

  @override
  WidgetDriverProvider<GradeAdditionPageDriver> get driverProvider => $GradeAdditionPageDriverProvider();
}
