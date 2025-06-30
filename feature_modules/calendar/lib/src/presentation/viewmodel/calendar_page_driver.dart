import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_calendar_usecase.dart';
import '../../application/usecase/get_events_by_date_usecase.dart';
import '../../domain/model/CalendarViewMode.dart';
import '../../domain/model/calendar.dart';
import '../../domain/model/calendar_entry.dart';
import '../view/calendar_event_contentsheet.dart';

part 'calendar_page_driver.g.dart';

@GenerateTestDriver()
class CalendarPageDriver extends WidgetDriver {
  final _getCalendarUsecase = GetIt.I.get<GetCalendarUsecase>();
  final _getCalendarEntriesByDateUsecase = GetIt.I.get<GetCalendarEntriesByDateUsecase>();

  late AppLocalizations _appLocalizations;
  late LmuToast _toast;

  late Calendar? _calendar;
  // late List<CalendarEntry>? _testEvent;
  late CalendarLoadState _calendarLoadState;

  late List<CalendarEntry>? _calendarEntries;
  late CalendarEntriesLoadState _calendarEntriesLoadState;

  bool get isLoading => _calendarLoadState != CalendarLoadState.success;
  bool _isLoadingEvents = true;
  bool get isLoadingEvents => _isLoadingEvents;
  String get largeTitle => "Calendar"; // TODO: Replace with localized title

  // String get calendarId => _calendar?.id ?? '';
  // String get title => _calendar?.name ?? '';

  // List<CalendarEntry> get testEvents => _testEvent ?? [];

  CalendarViewMode _viewMode = CalendarViewMode.list;
  DateTime _selectedDate = DateTime.now();
  // List<CalendarEntry> _calendarEntries = [];

  CalendarViewMode get viewMode => _viewMode;
  @TestDriverDefaultValue('2025-01-01')
  DateTime get selectedDate => _selectedDate;
  List<CalendarEntry>? get calendarEntries => _calendarEntries;
  // List<CalendarEvent> get events => mockEvents;

  // Future<void> init() async {
  //   await loadEvents();
  // }

  Future<void> loadEvents() async {
    _isLoadingEvents = true;
    notifyWidget();

    if (_viewMode == CalendarViewMode.day) {
      _calendarEntries = await _getCalendarEntriesByDateUsecase(date: _selectedDate);
    } else {
      _calendarEntries = await _getCalendarEntriesByDateUsecase(); // All events
    }

    _isLoadingEvents = false;
    notifyWidget();
  }

  void onViewModeChanged(CalendarViewMode mode) {
    _viewMode = mode;
    loadEvents();
  }

  void onDateSelected(DateTime date) {
    _selectedDate = date;
    if (_viewMode == CalendarViewMode.day) {
      loadEvents();
    }
  }

  void onEventTap(CalendarEntry event, BuildContext context) {
    openCalendarEventContentSheet(context, event: event);
  }

  // void onCalendarCardPressed() {
  //   _count += 1;
  //   notifyWidget();
  // }

  void onAddEventPressed() {
    // navigation or modal logic
  }

  void _onCalendarStateChanged() {
    _calendarLoadState = _getCalendarUsecase.loadState;
    _calendar = _getCalendarUsecase.data;
    // _testEvent = _getCalendarUsecase.testEvent;
    notifyWidget();

    if (_calendarLoadState == CalendarLoadState.error) {
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
    _calendarLoadState = _getCalendarUsecase.loadState;
    _calendar = _getCalendarUsecase.data;
    // _testEvent = _getCalendarUsecase.testEvent;
    _getCalendarUsecase.addListener(_onCalendarStateChanged);
    _getCalendarUsecase.load();
    // ------- Initial Load of Calendar Entries -------
    _calendarEntriesLoadState = _getCalendarEntriesByDateUsecase.loadState;
    _calendarEntries = _getCalendarEntriesByDateUsecase.data;
    loadEvents();
    _getCalendarEntriesByDateUsecase.addListener(_onCalendarEntriesStateChanged);
    _getCalendarEntriesByDateUsecase.load();
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _appLocalizations = context.locals.app;
    _toast = LmuToast.of(context);
  }

  @override
  void dispose() {
    _getCalendarUsecase.removeListener(_onCalendarStateChanged);
    _getCalendarEntriesByDateUsecase.removeListener(_onCalendarEntriesStateChanged);
    super.dispose();
  }
}
