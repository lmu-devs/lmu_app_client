import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:widget_driver/widget_driver.dart';

import '../component/developerdex_entry.dart';
import '../viewmodel/developerdex_page_driver.dart';

class DeveloperdexPage extends DrivableWidget<DeveloperdexPageDriver> {
  DeveloperdexPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                        backgroundColor: context.colors.customColors.textColors.stuBistro,
                        title: semesterCourse.semester.name.toUpperCase(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: LmuSizes.size_16),
                if (semesterCourse.developers.isNotEmpty)
                  SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final developer = semesterCourse.developers[index];
                        return DeveloperdexEntry(
                          wasSeen: index == 1,
                          assetName: developer.asset,
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
                          color: context.colors.neutralColors.backgroundColors.tile,
                        ),
                        child: Center(
                          child: LmuText.body(
                            "Available soon...",
                            color: context.colors.neutralColors.textColors.weakColors.active,
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
