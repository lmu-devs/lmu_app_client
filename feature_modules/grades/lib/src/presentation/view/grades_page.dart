import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:widget_driver/widget_driver.dart';

import '../viewmodel/grades_page_driver.dart';
import 'grade_addition_page.dart';
import 'grade_edit_page.dart';

class GradesPage extends DrivableWidget<GradesPageDriver> {
  GradesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.largeTitle,
        leadingAction: LeadingAction.back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: LmuSizes.size_16),
            LmuContentTile(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        LmuText.body("Notendurchschnitt"),
                        LmuText.h0(
                          driver.averageGrade,
                          textStyle: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: LmuSizes.size_24),
            LmuTileHeadline.base(title: "Gesamt ECTS"),
            LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  width: constraints.maxWidth,
                  height: 8,
                  decoration: BoxDecoration(
                    color: context.colors.neutralColors.backgroundColors.mediumColors.base,
                    borderRadius: BorderRadius.circular(LmuSizes.size_4),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: driver.progressValue * constraints.maxWidth,
                      height: 8,
                      decoration: BoxDecoration(
                        color: context.colors.brandColors.textColors.strongColors.base,
                        borderRadius: BorderRadius.circular(LmuSizes.size_4),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: LmuSizes.size_6),
            LmuText.bodySmall(
              driver.ectsProgress,
              textAlign: TextAlign.start,
              color: context.colors.brandColors.textColors.strongColors.base,
            ),
            const SizedBox(height: LmuSizes.size_24),
            LmuButton(
              title: "Note hinzufügen",
              leadingIcon: LucideIcons.plus,
              emphasis: ButtonEmphasis.secondary,
              showFullWidth: true,
              size: ButtonSize.large,
              onTap: () => GradeAdditionPage.show(context),
            ),
            const SizedBox(height: LmuSizes.size_32),
            LmuTileHeadline.base(title: "Deine Noten"),
            ...driver.groupedGrades.entries.map((entry) {
              final semester = entry.key;
              final grades = entry.value;

              return Padding(
                padding: const EdgeInsets.only(bottom: LmuSizes.size_16),
                child: LmuContentTile(
                  content: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: LmuListDropdown(
                      title: semester.name,
                      initialValue: true,
                      items: grades.map((grade) {
                        return LmuListItem.base(
                          title: grade.name,
                          subtitle: "${grade.ects} ECTS",
                          trailingTitle: grade.grade.toStringAsFixed(1),
                          hasHorizontalPadding: false,
                          hasVerticalPadding: false,
                          onTap: () => GradeEditPage.show(context, grade: grade),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: LmuSizes.size_96),
          ],
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<GradesPageDriver> get driverProvider => $GradesPageDriverProvider();
}
