import 'package:flutter/foundation.dart';

import '../../application/usecase/get_entries_by_date_usecase.dart';
import '../../domain/model/calendar_entry.dart';

class CalendarSearchService {
  CalendarSearchService({required GetCalendarEntriesByDateUsecase getCalendarEntriesByDateUsecase})
      : _getCalendarEntriesByDateUsecase = getCalendarEntriesByDateUsecase;

  final GetCalendarEntriesByDateUsecase _getCalendarEntriesByDateUsecase;

  List<CalendarEntry> get allCalendarEntries => _getCalendarEntriesByDateUsecase.data ?? [];

  List<String> _recentSearchIds = [];
  List<String> get recentSearchIds => _recentSearchIds;

  void init() {
    // TODO: maybe implement a recent searches loading
    // _recentSearchIds = await _calendarRepository.getRecentSearches();
  }

  CalendarEntry? getEntry(String id) {
    try {
      return allCalendarEntries.firstWhere((entry) => entry.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> updateRecentSearches(List<String> recentSearchIds) async {
    if (listEquals(_recentSearchIds, recentSearchIds)) return;
    _recentSearchIds = recentSearchIds;
    // TODO: optional if we want to save recent searches
    // await _calendarRepository.saveRecentSearches(recentSearchIds);
  }
}
