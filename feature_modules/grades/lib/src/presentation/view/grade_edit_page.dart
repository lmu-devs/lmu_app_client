import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/model/grade.dart';
import '../../domain/model/grade_semester.dart';
import '../helpers/grades_formatting_extension.dart';
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              LmuButton(
                title: "Speichern",
                size: ButtonSize.large,
                showFullWidth: true,
                state: driver.isSaveButtonEnabled ? ButtonState.enabled : ButtonState.disabled,
                onTap: () {
                  driver.onSaveGradePressed();
                  Navigator.of(context).pop();
                },
              ),
              LmuButton(
                title: "Löschen",
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
  WidgetDriverProvider<GradeEditPageDriver> get driverProvider => $GradeEditPageDriverProvider(gradeToEdit: grade);
}

class GradesInputFields extends StatelessWidget {
  const GradesInputFields({
    super.key,
    required this.driver,
  });

  final GradeEditPageDriver driver;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: Column(
        children: [
          const SizedBox(height: LmuSizes.size_24),
          LmuTileHeadline.base(title: "Name", customBottomPadding: 4),
          LmuInputField(
            hintText: "e.g. Mathematik 1",
            controller: driver.nameController,
            onChanged: driver.onNameChanged,
          ),
          const SizedBox(height: 16),
          LmuTileHeadline.base(title: "ECTS", customBottomPadding: 4),
          LmuInputField(
            hintText: "e.g. Mathematik 1",
            controller: driver.ectsController,
            onChanged: driver.onEctsChanged,
          ),
          const SizedBox(height: 16),
          LmuTileHeadline.base(title: "Note", customBottomPadding: 4),
          LmuInputField(
            hintText: "e.g. Mathematik 1",
            controller: driver.gradeController,
            onChanged: driver.onGradeChanged,
          ),
          const SizedBox(height: 12),
          LmuContentTile(
            content: LmuListItem.action(
              title: "Ohne Bewertung",
              actionType: LmuListItemAction.toggle,
            ),
          ),
        ],
      ),
    );
  }
}
