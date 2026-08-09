import 'package:core/logging.dart';
import 'package:flutter/material.dart';

import '../../domain/interface/calendar_repository_interface.dart';
import '../../domain/model/calendar_entry.dart';
import '../../domain/model/mock_events.dart';

final _appLogger = AppLogger();

class CalendarConfig {
  CalendarConfig({this.useHardcodedMockData = false});
  final bool useHardcodedMockData;
}

enum CalendarEntriesLoadState {
  initial,
  loading,
  loadingWithCache,
  success,
  successButStaleCache,
  error,
}

class GetCalendarEntriesByDateUsecase extends ChangeNotifier {
  GetCalendarEntriesByDateUsecase(this._repository, this._config);

  final CalendarRepositoryInterface _repository;
  final CalendarConfig _config;

  CalendarEntriesLoadState _loadState = CalendarEntriesLoadState.initial;
  List<CalendarEntry> _data = [];

  CalendarEntriesLoadState get loadState => _loadState;
  List<CalendarEntry> get data => _data;

  Future<void> load({bool force = false, DateTimeRange? dateRange}) async {
    if (!force &&
        (_loadState == CalendarEntriesLoadState.loading || _loadState == CalendarEntriesLoadState.loadingWithCache)) {
      return;
    }

    List<CalendarEntry>? cached;
    try {
      cached = await _repository.getCachedCalendarEntries();
    } catch (e) {
      _appLogger.logError("Failed to read cache: $e");
      cached = null;
    }

    if (cached != null && cached.isNotEmpty) {
      _setState(
        CalendarEntriesLoadState.loadingWithCache,
        _filter(cached, dateRange),
      );
    } else {
      _setState(CalendarEntriesLoadState.loading, []);
    }

    try {
      final freshData = await _getFreshData();

      _setState(
        CalendarEntriesLoadState.success,
        _filter(freshData, dateRange),
      );
    } catch (e) {
      _appLogger.logError("Calendar fetch failed: $e");

      if (cached != null && cached.isNotEmpty) {
        _setState(
          CalendarEntriesLoadState.successButStaleCache,
          _filter(cached, dateRange),
        );
      } else {
        _setState(
          CalendarEntriesLoadState.error,
          [],
        );
      }
    }
  }

  List<CalendarEntry> _filter(List<CalendarEntry> entries, DateTimeRange? range) {
    if (range == null) return entries;
    return entries.where((e) => e.overlapsWithRange(range)).toList();
  }

  Future<List<CalendarEntry>> _getFreshData() async {
    if (_config.useHardcodedMockData) {
      _appLogger.logMessage('Using hardcoded mock data.');
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      return mockCalendarEntries;
    }
    return _repository.getCalendarEvents();
  }

  void _setState(CalendarEntriesLoadState newState, List<CalendarEntry> newData) {
    if (_loadState != newState || _data != newData) {
      _loadState = newState;
      _data = newData;
      notifyListeners();
    }
  }
}
