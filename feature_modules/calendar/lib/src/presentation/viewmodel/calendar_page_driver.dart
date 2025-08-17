import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core/utils.dart';
import 'package:core_routes/calendar.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_entries_by_date_usecase.dart';
import '../../domain/model/calendar_entry.dart';
import '../../domain/model/calendar_view_type.dart';
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

  CalendarViewType _viewType = CalendarViewType.list;
  bool _isDatePickerExpanded = false;
  DateTimeRange _selectedDateTimeRange = DateTime.now().dateTimeRangeFromDateTime;
  int _scrollToDateRequest = 0;

  @TestDriverDefaultValue(false)
  bool get isDatePickerExpanded => _isDatePickerExpanded;
  @TestDriverDefaultValue(CalendarViewType.list)
  CalendarViewType get viewType => _viewType;
  @TestDriverDefaultValue('2025-01-01')
  DateTimeRange get selectedDateTimeRange => _selectedDateTimeRange;
  @TestDriverDefaultValue(0)
  int get scrollToDateRequest => _scrollToDateRequest;

  // Getter for the current date range
  // This code is only used for testing purposes as it is not very efficient to compute the date range every time
  Future<void> loadEvents() async {
    _calendarEntriesLoadState = CalendarEntriesLoadState.loading;
    notifyWidget();

    await _getCalendarEntriesByDateUsecase.load();
    // await _getCalendarEntriesByDateUsecase.load(dateRange: _selectedDateTimeRange);

    _allCalendarEntries = _getCalendarEntriesByDateUsecase.data;

    _calendarEntriesLoadState = CalendarEntriesLoadState.success;
    notifyWidget();
  }

  late List<CalendarEntry>? _allCalendarEntries;

  List<CalendarEntry>? get calendarEntries {
    if (_allCalendarEntries == null) return null;
    return _allCalendarEntries!.where((entry) {
      return entry.overlapsWithRange(_selectedDateTimeRange);
    }).toList();
  }

  void onCalendarViewTypeChanged(CalendarViewType mode) {
    _viewType = mode;
    loadEvents();
  }

  void onDateTimeRangeSelected(DateTimeRange dateRange) {
    _selectedDateTimeRange = dateRange;
    notifyWidget();
  }

  void onExpandDatePickerPressed() {
    _isDatePickerExpanded = !_isDatePickerExpanded;
    notifyWidget();
  }

  void onChangeToTodayPressed() {
    _selectedDateTimeRange = DateTime.now().dateTimeRangeFromDateTime;
    _scrollToDateRequest++;
    notifyWidget();
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
