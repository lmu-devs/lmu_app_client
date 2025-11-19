import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../viewmodel/courses_search_driver.dart';

class CoursesSearchPage extends DrivableWidget<CoursesSearchDriver> {
  CoursesSearchPage({super.key, required this.facultyId});

  final int facultyId;

  @override
  Widget build(BuildContext context) {
    return LmuSearchPage<CourseSearchEntry>(
      searchEntryBuilder: (entry) => driver.buildSearchEntry(context, entry),
      searchEntries: driver.searchEntries,
      recentSearchEntries: driver.recentSearchEntries,
      onRecentSearchesUpdated: driver.updateRecentSearch,
      recentSearchController: driver.recentSearchController,
    );
  }

  @override
  WidgetDriverProvider<CoursesSearchDriver> get driverProvider => $CoursesSearchDriverProvider(facultyId: facultyId);
}
