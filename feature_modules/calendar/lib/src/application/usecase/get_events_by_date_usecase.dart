import 'package:core/logging.dart';
import 'package:flutter/material.dart';

import '../../domain/exception/calendar_events_generic_exception.dart';
import '../../domain/interface/calendar_repository_interface.dart';
import '../../domain/model/calendar_entry.dart';

enum CalendarEntriesLoadState { initial, loading, loadingWithCache, success, error }

final _appLogger = AppLogger();

class GetCalendarEntriesByDateUsecase extends ChangeNotifier {
  GetCalendarEntriesByDateUsecase(this._repository);

  final CalendarRepositoryInterface _repository;

  CalendarEntriesLoadState _loadState = CalendarEntriesLoadState.initial;
  List<CalendarEntry>? _data;

  CalendarEntriesLoadState get loadState => _loadState;
  List<CalendarEntry>? get data => _data;

  Future<void> load({DateTimeRange? dateRange}) async {
    if (_loadState == CalendarEntriesLoadState.loading ||
        _loadState == CalendarEntriesLoadState.loadingWithCache ||
        _loadState == CalendarEntriesLoadState.success) {
      return;
    }

    final cached = await _repository.getCachedCalendarEntries();
    if (cached != null) {
      _loadState = CalendarEntriesLoadState.loadingWithCache;
      _data = dateRange == null ? cached : cached.where((e) => e.overlapsWithRange(dateRange)).toList();
      notifyListeners();
    } else {
      _loadState = CalendarEntriesLoadState.loading;
      _data = null;
      notifyListeners();
    }

    try {
      final result = await _repository.getCalendarEvents();
      _loadState = CalendarEntriesLoadState.success;
      _data = dateRange == null ? result : result.where((e) => e.overlapsWithRange(dateRange)).toList();
      notifyListeners();
    } on CalendarEntriesGenericException {
      if (cached != null) {
        _loadState = CalendarEntriesLoadState.success;
        _data = dateRange == null ? cached : cached.where((e) => e.overlapsWithRange(dateRange)).toList();
        notifyListeners();
      } else {
        _loadState = CalendarEntriesLoadState.error;
        _data = null;
        notifyListeners();
      }
    }

    _appLogger.logMessage('--> Loaded ${_data?.length ?? 0} calendar entries for date range: $dateRange');
  }
}
