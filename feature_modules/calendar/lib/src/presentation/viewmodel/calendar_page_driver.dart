import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core/utils.dart';
import 'package:core_routes/calendar.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_events_by_date_usecase.dart';
import '../../domain/model/calendar_entry.dart';
import '../../domain/model/calendar_view_mode.dart';
import '../view/calendar_event_contentsheet.dart';

part 'calendar_page_driver.g.dart';

@GenerateTestDriver()
class CalendarPageDriver extends WidgetDriver {
  final _getCalendarEntriesByDateUsecase = GetIt.I.get<GetCalendarEntriesByDateUsecase>();

  late AppLocalizations _appLocalizations;
  late LmuToast _toast;

  late List<CalendarEntry>? _calendarEntries;
  late CalendarEntriesLoadState _calendarEntriesLoadState;

  bool get isLoadingEvents => _calendarEntriesLoadState != CalendarEntriesLoadState.success;
  String get largeTitle => "Calendar"; // TODO: Replace with localized title

  CalendarViewMode _viewMode = CalendarViewMode.list;
  DateTimeRange _selectedDateTimeRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 365)),
    end: DateTime.now().add(const Duration(days: 365)),
  );

  CalendarViewMode get viewMode => _viewMode;
  @TestDriverDefaultValue('2025-01-01')
  DateTimeRange get selectedDate => _selectedDateTimeRange;

  // Getter for the current date range
  // This code is only used for testing purposes as it is not very efficient to compute the date range every time
  Future<void> loadEvents() async {
    _calendarEntriesLoadState = CalendarEntriesLoadState.loading;
    notifyWidget();

    await _getCalendarEntriesByDateUsecase.load();
    // await _getCalendarEntriesByDateUsecase.load(dateRange: _selectedDateTimeRange);

    _allCalendarEntries = _getCalendarEntriesByDateUsecase.data;

    _calendarEntriesLoadState = CalendarEntriesLoadState.success;
    notifyWidget(); // This will trigger recompute of `calendarEntries`
  }

  late List<CalendarEntry>? _allCalendarEntries;

  List<CalendarEntry>? get calendarEntries {
    if (_allCalendarEntries == null) return null;
    return _allCalendarEntries!.where((entry) {
      return entry.overlapsWithRange(_selectedDateTimeRange);
    }).toList();
  }

  void onViewModeChanged(CalendarViewMode mode) {
    if (_viewMode != mode) {
      if (mode == CalendarViewMode.list) {
        final weekStart = _selectedDateTimeRange.start.startOfWeek;
        final weekEnd = weekStart.add(const Duration(days: 6));
        _selectedDateTimeRange = DateTimeRange(start: weekStart, end: weekEnd);
      } else if (mode == CalendarViewMode.day) {
        final day = _selectedDateTimeRange.start;
        _selectedDateTimeRange = DateTimeRange(start: day.startOfDay, end: day.endOfDay);
      }
    }
    _viewMode = mode;
    loadEvents();
  }

  void onDateSelected(DateTimeRange dateRange) {
    _selectedDateTimeRange = dateRange;
    if (_viewMode == CalendarViewMode.day) {
      loadEvents();
    }
  }

  void onEventTap(CalendarEntry event, BuildContext context) {
    openCalendarEventContentSheet(context, event: event);
  }

  void onAddEventPressed() {
    // navigation or modal logic
  }

  void onTestScreenPressed(BuildContext context) {
    const CalendarTestRoute().go(context);
  }

  void _onCalendarEntriesStateChanged() {
    _calendarEntriesLoadState = _getCalendarEntriesByDateUsecase.loadState;
    _calendarEntries = _getCalendarEntriesByDateUsecase.data;
    notifyWidget();

    if (_calendarEntriesLoadState == CalendarEntriesLoadState.error) {
      _showErrorToast();
    }
  }

  void _onCalendarEntriesStateChanged() {
    _calendarEntriesLoadState = _getCalendarEntriesByDateUsecase.loadState;
    _calendarEntries = _getCalendarEntriesByDateUsecase.data;
    notifyWidget();

    if (_calendarEntriesLoadState == CalendarEntriesLoadState.error) {
      _showErrorToast();
    }
  }

  void _showErrorToast() {
    _toast.showToast(
      message: _appLocalizations.somethingWentWrong,
      type: ToastType.error,
      actionText: _appLocalizations.tryAgain,
      onActionPressed: () => _getCalendarEntriesByDateUsecase.load(),
    );
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _calendarEntriesLoadState = _getCalendarEntriesByDateUsecase.loadState;
    _calendarEntries = _getCalendarEntriesByDateUsecase.data;
    loadEvents();
    _getCalendarEntriesByDateUsecase.addListener(_onCalendarEntriesStateChanged);
    _getCalendarEntriesByDateUsecase.load(dateRange: _selectedDateTimeRange);
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _appLocalizations = context.locals.app;
    _toast = LmuToast.of(context);
  }

  @override
  void dispose() {
    _getCalendarEntriesByDateUsecase.removeListener(_onCalendarEntriesStateChanged);
    super.dispose();
  }
}
