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

  CalendarEntriesLoadState? _lastLoadState;

  late List<CalendarEntry> _calendarEntries = [];
  late List<CalendarEntry> _allCalendarEntries = [];

  bool get isLoadingEvents =>
      _getCalendarEntriesByDateUsecase.loadState == CalendarEntriesLoadState.loading ||
      _getCalendarEntriesByDateUsecase.loadState == CalendarEntriesLoadState.loadingWithCache;

  bool get hasErrorLoadingEvents => _getCalendarEntriesByDateUsecase.loadState == CalendarEntriesLoadState.error;

  bool get loadedFromStaleCache =>
      _getCalendarEntriesByDateUsecase.loadState == CalendarEntriesLoadState.successButStaleCache;

  String get largeTitle => "Calendar"; // TODO: Replace with localized title

  CalendarViewType _viewType = CalendarViewType.list;
  bool _isDatePickerExpanded = false;
  DateTimeRange _selectedDateTimeRange = DateTime.now().dateTimeRangeFromDateTime;
  int _scrollToDateRequest = 0;

  @TestDriverDefaultValue(false)
  bool get isDatePickerExpanded => _isDatePickerExpanded;
  @TestDriverDefaultValue(CalendarViewType.list)
  CalendarViewType get viewType => _viewType;
  @TestDriverDefaultValue(null)
  DateTimeRange? get selectedDateTimeRange => _selectedDateTimeRange;
  @TestDriverDefaultValue(0)
  int get scrollToDateRequest => _scrollToDateRequest;

  Future<void> loadEvents() async {
    await _getCalendarEntriesByDateUsecase.load();
  }

  List<CalendarEntry> get calendarEntries {
    return _allCalendarEntries;
    // .where((entry) {
    //   return entry.overlapsWithRange(_selectedDateTimeRange);
    // }).toList();
  }

  void onCalendarViewTypeChanged(CalendarViewType mode) {
    _viewType = mode;
    notifyWidget();
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

  void onSearchPressed(BuildContext context) {
    const CalendarSearchRoute().go(context);
  }

  void onCreatePressed(BuildContext context) {
    const CalendarCreateRoute().go(context);
  }

  void _onUseCaseUpdate() {
    final currentState = _getCalendarEntriesByDateUsecase.loadState;

    // 1. Update Data
    _calendarEntries = _getCalendarEntriesByDateUsecase.data;
    _allCalendarEntries = _calendarEntries;

    // 2. Handle Side Effects (Toasts) ONLY if state actually changed
    if (currentState != _lastLoadState) {
      if (currentState == CalendarEntriesLoadState.error) {
        _showErrorToast();
      } else if (currentState == CalendarEntriesLoadState.successButStaleCache) {
        _showStaleCacheToast();
      }
      _lastLoadState = currentState;
    }

    // 3. Update UI
    notifyWidget();
  }

  // void _onCalendarEntriesStateChanged() {
  //   _calendarEntries = _getCalendarEntriesByDateUsecase.data;
  //   _allCalendarEntries = _calendarEntries;

  //   notifyWidget();

  //   if (_getCalendarEntriesByDateUsecase.loadState == CalendarEntriesLoadState.error) {
  //     _showErrorToast();
  //   }
  // }

  void _showErrorToast() {
    _toast.showToast(
      message: _appLocalizations.somethingWentWrong,
      type: ToastType.error,
      actionText: _appLocalizations.tryAgain,
      onActionPressed: () => _getCalendarEntriesByDateUsecase.load(force: true),
      duration: const Duration(seconds: 5),
    );
  }

  void _showStaleCacheToast() {
    _toast.showToast(
      message: 'Daten aus dem Cache geladen.',
      // message: '${_appLocalizations.loadedFromCache}\n${_appLocalizations.tryRefreshingData}',
      type: ToastType.warning,
      actionText: _appLocalizations.tryAgain,
      onActionPressed: () => _getCalendarEntriesByDateUsecase.load(force: true),
      duration: const Duration(seconds: 5),
    );
  }

  // void notifyListeners() {
  //   super.notifyWidget();

  //   if (loadedFromStaleCache) {
  //   }
  // }

  @override
  void didInitDriver() {
    super.didInitDriver();
    // Add ONLY one listener
    _getCalendarEntriesByDateUsecase.addListener(_onUseCaseUpdate);
    loadEvents();
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _appLocalizations = context.locals.app;
    _toast = LmuToast.of(context);
  }

  @override
  void dispose() {
    _getCalendarEntriesByDateUsecase.removeListener(_onUseCaseUpdate);
    super.dispose();
  }
}
