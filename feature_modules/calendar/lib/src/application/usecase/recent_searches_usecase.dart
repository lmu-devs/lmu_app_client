import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../../domain/model/calendar_entry.dart';
import '../../infrastructure/secondary/data/storage/calendar_recent_searches_storage.dart';
import 'get_entries_by_date_usecase.dart';

class RecentSearchesUsecase extends ChangeNotifier {
  RecentSearchesUsecase(this._storage, this._getCalendarEntriesByDateUsecase) {
    _load();
  }

  final CalendarRecentSearchesStorage _storage;
  final GetCalendarEntriesByDateUsecase _getCalendarEntriesByDateUsecase;
  final List<String> _recentSearchIds = [];
  final ValueNotifier<List<CalendarEntry>> recentSearchesNotifier = ValueNotifier<List<CalendarEntry>>([]);

  List<CalendarEntry> get recentSearches {
    final allCalendarEntries = _getCalendarEntriesByDateUsecase.data;
    return _recentSearchIds
        .map((id) => allCalendarEntries.where((entry) => entry.id == id).firstOrNull)
        .whereType<CalendarEntry>()
        .toList();
  }

  Future<void> addRecentSearch(String calendarEntryId) async {
    _updateRecentSearchIds(calendarEntryId);
    await _storage.saveRecentSearches(_recentSearchIds.map((e) => e.toString()).toList());
    _updateRecentSearchesNotifier();
    notifyListeners();
  }

  Future<void> clearRecentSearches() async {
    _recentSearchIds.clear();
    await _storage.clearRecentSearches();
    recentSearchesNotifier.value = [];
    notifyListeners();
  }

  Future<void> _load() async {
    _recentSearchIds.clear();
    final stringIds = await _storage.getRecentSearches();
    _recentSearchIds.addAll(stringIds);
    _updateRecentSearchesNotifier();
    notifyListeners();
  }

  void _updateRecentSearchIds(String id) {
    _recentSearchIds.removeWhere((element) => element == id);
    _recentSearchIds.insert(0, id);

    if (_recentSearchIds.length > 10) {
      _recentSearchIds.removeRange(10, _recentSearchIds.length);
    }
  }

  void _updateRecentSearchesNotifier() {
    recentSearchesNotifier.value = recentSearches;
  }
}
