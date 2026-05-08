import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../viewmodel/people_search_driver.dart';

class PeopleSearchPage extends DrivableWidget<PeopleSearchDriver> {
  PeopleSearchPage({super.key, required this.facultyId});

  final int facultyId;

  @override
  Widget build(BuildContext context) {
    return LmuSearchPage<PeopleSearchEntry>(
      searchEntryBuilder: (entry) => driver.buildSearchEntry(context, entry),
      searchEntries: driver.searchEntries,
      recentSearchEntries: driver.recentSearchEntries,
      onRecentSearchesUpdated: driver.updateRecentSearch,
      recentSearchController: driver.recentSearchController,
    );
  }

  @override
  WidgetDriverProvider<PeopleSearchDriver> get driverProvider => $PeopleSearchDriverProvider(facultyId: facultyId);
}
