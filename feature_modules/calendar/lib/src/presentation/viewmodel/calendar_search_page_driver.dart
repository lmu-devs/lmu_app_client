import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/model/calendar_entry.dart';
import 'calendar_search_service.dart';

part 'calendar_search_page_driver.g.dart';

@GenerateTestDriver()
class CalendarSearchPageDriver extends WidgetDriver {
  final _searchService = GetIt.I.get<CalendarSearchService>();

  @TestDriverDefaultValue([])
  List<CalendarEntry> get allCalendarEntries => _searchService.allCalendarEntries;

  @TestDriverDefaultValue([])
  List<String> get recentSearchIds => _searchService.recentSearchIds;

  CalendarEntry? getEntry(String id) {
    return _searchService.getEntry(id);
  }

  Future<void> updateRecentSearches(List<String> recentSearchIds) async {
    await _searchService.updateRecentSearches(recentSearchIds);
    notifyWidget();
  }
}
