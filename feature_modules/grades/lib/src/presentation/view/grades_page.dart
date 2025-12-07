import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/model/grade_semester.dart';
import '../component/grades_ects_progress.dart';
import '../component/grades_empty_state.dart';
import '../component/grades_score_card.dart';
import '../component/grades_toggle_list_item.dart';
import '../helpers/grades_filter_extension.dart';
import '../viewmodel/grades_page_driver.dart';
import 'grade_addition_page.dart';

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
          children: [
            const SizedBox(height: LmuSizes.size_16),
            GradesScoreCard(averageGrade: driver.averageGrade),
            const SizedBox(height: LmuSizes.size_16),
            GradesEctsProgress(
              archievedEcts: driver.archievedEcts,
              maxEcts: driver.maxEcts,
            ),
            const SizedBox(height: LmuSizes.size_24),
            LmuButton(
              title: driver.addGradeTitle,
              leadingIcon: LucideIcons.plus,
              emphasis: ButtonEmphasis.secondary,
              showFullWidth: true,
              size: ButtonSize.large,
              onTap: () => GradeAdditionPage.show(context),
            ),
            const SizedBox(height: LmuSizes.size_32),
            LmuTileHeadline.base(title: driver.gradesCountTitle),
            if (driver.hasGrades)
              ...driver.groupedGrades.entries.map(
                (entry) {
                  final semester = entry.key;
                  final grades = entry.value;
                  final activeGrades = grades.activeGrades;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: LmuSizes.size_16),
                    child: LmuContentTile(
                      content: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_12),
                        child: LmuListDropdown(
                          key: Key("grades_semester_${semester.index}"),
                          title: semester.localizedName(context.locals.grades),
                          trailingSubtitle: driver.calculateSemesterAverage(activeGrades),
                          bottomSpacing: LmuSizes.size_4,
                          initialValue: true,
                          items: driver
                              .getOrderedGrades(grades)
                              .map(
                                (grade) => GradesToggleListItem(
                                  key: Key("grade_item_${grade.id}"),
                                  grade: grade,
                                  onActiveChanged: (isActive) => driver.toggleGradeActiveState(grade, isActive),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  );
                },
              )
            else
              const GradesEmptyState(),
            const SizedBox(height: LmuSizes.size_96),
          ],
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<GradesPageDriver> get driverProvider => $GradesPageDriverProvider();
}
