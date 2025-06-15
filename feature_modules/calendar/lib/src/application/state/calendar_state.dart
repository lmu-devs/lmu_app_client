import 'package:flutter/foundation.dart';

import '../usecase/get_cached_calendar_usecase.dart';
import '../usecase/get_calendar_usecase.dart';
import '../../domain/model/calendar.dart';

enum CalendarLoadState { initial, loading, loadingWithCache, success, error }

typedef CalendarState = ({ CalendarLoadState loadState, Calendar? calendar });

class CalendarStateService {
  CalendarStateService(this._getCalendarUsecase, this._getCachedCalendarUsecase);

  final GetCalendarUsecase _getCalendarUsecase;
  final GetCachedCalendarUsecase _getCachedCalendarUsecase;

  final ValueNotifier<CalendarState> _stateNotifier = ValueNotifier<CalendarState>(
    (loadState: CalendarLoadState.initial, calendar: null),
  );

  ValueListenable<CalendarState> get stateNotifier => _stateNotifier;

  Future<void> getCalendar() async {
    final currentState = _stateNotifier.value.loadState;
    if (currentState == CalendarLoadState.loading || currentState == CalendarLoadState.success) return;

    final cachedCalendar = await _getCachedCalendarUsecase.call();
    if (cachedCalendar != null) {
      _stateNotifier.value = (loadState: CalendarLoadState.loadingWithCache, calendar: cachedCalendar);
    } else {
      _stateNotifier.value = (loadState: CalendarLoadState.loading, calendar: null);
    }

    final calendar = await _getCalendarUsecase.call();
    if (calendar != null) {
      _stateNotifier.value = (loadState: CalendarLoadState.success, calendar: calendar);
      return;
    }
    _stateNotifier.value = (loadState: CalendarLoadState.error, calendar: null);
  }
}
