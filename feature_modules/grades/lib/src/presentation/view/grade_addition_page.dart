import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/model/grade_semester.dart';
import '../helpers/grades_formatting_extension.dart';
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
          padding: const EdgeInsets.all(16.0),
          child: LmuButton(
            title: "Hinzufügen",
            size: ButtonSize.large,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          LmuButtonRow(
            buttons: GradeSemester.values.reversed.map((semester) {
              final isSelected = driver.selectedGradeSemester == semester;
              return LmuButton(
                title: semester.localizedName(context.locals.grades),
                emphasis: isSelected ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
                action: isSelected ? ButtonAction.contrast : ButtonAction.base,
                onTap: () => driver.onGradeSemesterSelected(semester),
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 24),
                LmuTileHeadline.base(title: "Name", customBottomPadding: 4),
                LmuInputField(
                  hintText: "e.g. Mathematik 1",
                  controller: driver.nameController,
                  onChanged: driver.onNameChanged,
                ),
                const SizedBox(height: 16),
                LmuTileHeadline.base(title: "ECTS", customBottomPadding: 4),
                LmuInputField(
                  hintText: "e.g. 5",
                  controller: driver.ectsController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onChanged: driver.onEctsChanged,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: LmuTileHeadline.base(title: "Note", customBottomPadding: 8),
          ),
          LmuButtonRow(
            buttons: [
              LmuButton(
                title: "Bestanden",
                emphasis: driver.selectedGrade == null ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
                action: driver.selectedGrade == null ? ButtonAction.contrast : ButtonAction.base,
                onTap: () => driver.onGradeSelected(null),
              ),
              ...driver.availableGrades.map(
                (grade) {
                  final isSelected = driver.selectedGrade == grade;
                  return LmuButton(
                    title: grade.asStringWithOneDecimal,
                    emphasis: isSelected ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
                    action: isSelected ? ButtonAction.contrast : ButtonAction.base,
                    onTap: () => driver.onGradeSelected(grade),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: LmuSizes.size_96),
        ],
      ),
    );
  }

  @override
  WidgetDriverProvider<GradeAdditionPageDriver> get driverProvider => $GradeAdditionPageDriverProvider();
}
