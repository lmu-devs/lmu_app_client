import 'package:flutter/foundation.dart';

import '../../domain/exception/calendar_generic_exception.dart';
import '../../domain/interface/calendar_repository_interface.dart';
import '../../domain/model/calendar.dart';

enum CalendarLoadState { initial, loading, loadingWithCache, success, error }

class GetCalendarUsecase extends ChangeNotifier {
  GetCalendarUsecase(this._repository);

  final CalendarRepositoryInterface _repository;

  CalendarLoadState _loadState = CalendarLoadState.initial;
  Calendar? _data;

  CalendarLoadState get loadState => _loadState;
  Calendar? get data => _data;

  Future<void> load() async {
    if (_loadState == CalendarLoadState.loading ||
        _loadState == CalendarLoadState.loadingWithCache ||
        _loadState == CalendarLoadState.success) {
      return;
    }

    final cached = await _repository.getCachedCalendar();
    if (cached != null) {
      _loadState = CalendarLoadState.loadingWithCache;
      _data = cached;
      notifyListeners();
    } else {
      _loadState = CalendarLoadState.loading;
      _data = null;
      notifyListeners();
    }

    try {
      final result = await _repository.getCalendar();
      _loadState = CalendarLoadState.success;
      _data = result;
    } on CalendarGenericException {
      if (cached != null) {
        _loadState = CalendarLoadState.success;
        _data = cached;
      } else {
        _loadState = CalendarLoadState.error;
        _data = null;
      }
    }

    notifyListeners();
  }
}
