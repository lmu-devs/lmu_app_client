import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../viewmodel/calendar_search_page_driver.dart';

class CalendarSearchPage extends DrivableWidget<CalendarSearchPageDriver> {
  CalendarSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuSearchPage<CalendarSearchEntry>(
      searchEntries: driver.searchEntries,
      emptySearchEntriesTitle: driver.youngestEntriesTitle,
      emptySearchEntries: driver.youngestFiveEntriesByCreationDate,
      recentSearchEntries: driver.recentSearchEntries,
      recentSearchController: driver.recentSearchController,
      onRecentSearchesUpdated: driver.updateRecentSearch,
      searchEntryBuilder: (entry) => driver.buildSearchEntry(context, entry),
    );
  }

  @override
  WidgetDriverProvider<CalendarSearchPageDriver> get driverProvider => $CalendarSearchPageDriverProvider();
}
