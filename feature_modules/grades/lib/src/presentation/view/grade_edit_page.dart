import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/model/grade.dart';
import '../component/grade_form_body.dart';
import '../viewmodel/grade_edit_page_driver.dart';

class GradeEditPage extends DrivableWidget<GradeEditPageDriver> {
  GradeEditPage({super.key, required this.grade});

  final Grade grade;

  static void show(BuildContext context, {required Grade grade}) {
    LmuBottomSheet.showExtended(
      context,
      content: GradeEditPage(grade: grade),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: LmuSizes.size_16,
            children: [
              LmuButton(
                title: driver.saveButtonTitle,
                size: ButtonSize.large,
                showFullWidth: true,
                state: driver.isSaveButtonEnabled ? ButtonState.enabled : ButtonState.disabled,
                onTap: () {
                  driver.onSaveGradePressed();
                  Navigator.of(context).pop();
                },
              ),
              LmuButton(
                title: driver.deleteButtonTitle,
                size: ButtonSize.large,
                showFullWidth: true,
                emphasis: ButtonEmphasis.link,
                action: ButtonAction.destructive,
                onTap: () {
                  driver.onDeleteGradePressed();
                  Navigator.of(context).pop();
                },
              ),
            ],
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
  WidgetDriverProvider<GradeEditPageDriver> get driverProvider => $GradeEditPageDriverProvider(gradeToEdit: grade);
}
