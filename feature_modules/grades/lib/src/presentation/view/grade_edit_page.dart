import 'package:core/components.dart';
import 'package:core/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/model/grade.dart';
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
          child: Row(
            mainAxisSize: MainAxisSize.max,
            spacing: 16,
            children: [
              Expanded(
                child: LmuButton(
                  title: "Löschen",
                  size: ButtonSize.large,
                  action: ButtonAction.destructive,
                  onTap: () {
                    driver.onDeleteGradePressed();
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Expanded(
                child: LmuButton(
                  title: "Speichern",
                  size: ButtonSize.large,
                  state: driver.isSaveButtonEnabled ? ButtonState.enabled : ButtonState.disabled,
                  onTap: () {
                    driver.onSaveGradePressed();
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: LmuAppBarData(
        largeTitle: driver.largeTitle,
        leadingAction: LeadingAction.close,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            LmuTileHeadline.base(title: "Semester"),
            LmuListDropdown(
              title: driver.selectedGradeSemester.name,
              items: [
                for (final semester in GradeSemester.values.reversed)
                  LmuListItem.base(
                    title: driver.selectedGradeSemester == semester ? semester.name : null,
                    subtitle: driver.selectedGradeSemester == semester ? null : semester.name,
                    onTap: () {
                      driver.onGradeSemesterSelected(semester);
                    },
                  ),
              ],
            ),
            const SizedBox(height: 24),
            LmuTileHeadline.base(title: "Name"),
            LmuInputField(
              hintText: "e.g. Mathematik 1",
              controller: driver.nameController,
              onChanged: driver.onNameChanged,
            ),
            const SizedBox(height: 16),
            LmuTileHeadline.base(title: "Note"),
            LmuInputField(
              hintText: "e.g. 1.3",
              controller: driver.gradeController,
              keyboardType: TextInputType.number,
              onChanged: driver.onGradeChanged,
            ),
            const SizedBox(height: 16),
            LmuTileHeadline.base(title: "ECTS"),
            LmuInputField(
              hintText: "e.g. 5",
              controller: driver.ectsController,
              keyboardType: TextInputType.number,
              onChanged: driver.onEctsChanged,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<GradeEditPageDriver> get driverProvider => $GradeEditPageDriverProvider(gradeToEdit: grade);
}
