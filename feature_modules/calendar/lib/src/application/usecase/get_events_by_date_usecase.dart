import 'package:flutter/foundation.dart';

import '../../domain/exception/calendar_events_generic_exception.dart';
import '../../domain/interface/calendar_repository_interface.dart';
import '../../domain/model/calendar_entry.dart';

enum CalendarEntriesLoadState { initial, loading, loadingWithCache, success, error }

class GetCalendarEntriesByDateUsecase extends ChangeNotifier {
  GetCalendarEntriesByDateUsecase(this._repository);

  final CalendarRepositoryInterface _repository;

  CalendarEntriesLoadState _loadState = CalendarEntriesLoadState.initial;
  List<CalendarEntry>? _data;

  CalendarEntriesLoadState get loadState => _loadState;
  List<CalendarEntry>? get data => _data;

  Future<void> load() async {
    if (_loadState == CalendarEntriesLoadState.loading ||
        _loadState == CalendarEntriesLoadState.loadingWithCache ||
        _loadState == CalendarEntriesLoadState.success) {
      return;
    }

    final cached = await _repository.getCachedCalendarEntries();
    if (cached != null) {
      _loadState = CalendarEntriesLoadState.loadingWithCache;
      _data = cached;
      notifyListeners();
    } else {
      _loadState = CalendarEntriesLoadState.loading;
      _data = null;
      notifyListeners();
    }

    try {
      final result = await _repository.getCalendarEvents();
      // final result = await _repository.getCalendar();
      _loadState = CalendarEntriesLoadState.success;
      _data = result;
    } on CalendarEntriesGenericException {
      if (cached != null) {
        _loadState = CalendarEntriesLoadState.success;
        _data = cached;
      } else {
        _loadState = CalendarEntriesLoadState.error;
        _data = null;
      }
    }
  }

  // Future<List<CalendarEvent>> call({DateTime? date}) async {
  //   final allEvents = await _repository.getCalendarEvents();
  //   if (date == null) return allEvents;
  //   return allEvents.where((e) => e.occursOn(date)).toList();
  // }

  // Future<List<CalendarEvent>> call({DateTime? date}) async {
  //   final allEvents = await _repository.getCalendarEvents();
  //   print("Returned ${allEvents.length} events");
  //   return allEvents; // temporär: kein Filter
  // }

  Future<List<CalendarEntry>> call({DateTime? date}) async {
    final allEvents = await _repository.getCalendarEvents();
    print("Returned ${allEvents.length} events");

    if (date == null) return allEvents;

    return allEvents.where((event) => event.occursOn(date)).toList();
  }
}
