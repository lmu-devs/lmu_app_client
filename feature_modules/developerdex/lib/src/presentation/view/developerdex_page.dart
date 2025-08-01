import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/model/animal.dart';
import '../../domain/model/semester.dart';
import '../component/developerdex_entry.dart';
import '../viewmodel/developerdex_page_driver.dart';
import 'developer_details_page.dart';

class DeveloperdexPage extends DrivableWidget<DeveloperdexPageDriver> {
  DeveloperdexPage({super.key});

  @override
  Widget build(BuildContext context) {
    final neutralColors = context.colors.neutralColors;
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.appBarTitle,
        leadingAction: LeadingAction.back,
      ),
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: LmuSizes.size_16)),
        ...driver.semesterCourses.mapIndexed(
          (index, semesterCourse) => SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
            sliver: MultiSliver(
              children: [
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LmuInTextVisual.text(
                        title: semesterCourse.semester.localizedName,
                        backgroundColor: context.colors.customColors.backgroundColors.pink,
                        textColor: context.colors.customColors.textColors.pink,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: LmuSizes.size_16),
                if (semesterCourse.state == SemesterState.finished)
                  SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final developer = semesterCourse.developers[index];
                        final wasSeen = driver.wasDeveloperSeen(developer.id);
                        return DeveloperdexEntry(
                          wasSeen: wasSeen,
                          assetName: developer.animal.asset,
                          onTap: () {
                            if (!wasSeen) return;
                            LmuBottomSheet.showExtended(
                              context,
                              content: DeveloperDetailsPage(developer: developer),
                            );
                          },
                        );
                      },
                      childCount: semesterCourse.developers.length,
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: LmuSizes.size_12,
                      crossAxisSpacing: LmuSizes.size_12,
                      childAspectRatio: 1,
                    ),
                  )
                else
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final height = (constraints.maxWidth - LmuSizes.size_24) / 3;
                      return Container(
                        width: constraints.maxWidth,
                        height: height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(LmuSizes.size_12),
                          color: neutralColors.backgroundColors.tile,
                        ),
                        child: Center(
                          child: semesterCourse.state == SemesterState.inProgress
                              ? LmuText.body(
                                  "Available soon",
                                  color: neutralColors.textColors.weakColors.active,
                                )
                              : Text.rich(
                                  TextSpan(
                                    text: "Apply now",
                                    style: context.textTheme.bodySmall.copyWith(
                                      color: neutralColors.textColors.mediumColors.base,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        LmuUrlLauncher.launchWebsite(
                                          url: LmuDevStrings.lmuDevWebsite,
                                          context: context,
                                        );
                                      },
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: index == driver.semesterCourses.length - 1 ? LmuSizes.size_96 : LmuSizes.size_32,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  WidgetDriverProvider<DeveloperdexPageDriver> get driverProvider => $DeveloperdexPageDriverProvider();
}
