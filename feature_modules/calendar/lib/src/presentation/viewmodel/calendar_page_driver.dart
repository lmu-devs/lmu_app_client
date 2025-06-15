import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/state/calendar_state.dart';
import '../../domain/model/calendar.dart';

part 'calendar_page_driver.g.dart';

@GenerateTestDriver()
class CalendarPageDriver extends WidgetDriver {
  final _calendarStateService = GetIt.I.get<CalendarStateService>();

  late AppLocalizations _appLocalizations;
  late LmuToast _toast;

  late Calendar? _calendar;
  late CalendarLoadState _calendarLoadState;

  int _count = 0;

  bool get isLoading => _calendarLoadState != CalendarLoadState.success;

  String get largeTitle => "Calendar"; // TODO: Replace with localized title

  String get calendarId => _calendar?.id ?? '';

  String get title => _calendar?.name ?? '';

  String get description => _count.toString();

  void onCalendarCardPressed() {
    _count += 1;
    notifyWidget();
  }

  void _onCalendarStateChanged() {
    final state = _calendarStateService.stateNotifier.value;
    _calendarLoadState = state.loadState;
    _calendar = state.calendar;
    notifyWidget();

    if (_calendarLoadState == CalendarLoadState.error) {
      _showErrorToast();
    }
  }

  void _showErrorToast() {
    _toast.showToast(
      message: _appLocalizations.somethingWentWrong,
      type: ToastType.error,
      actionText: _appLocalizations.tryAgain,
      onActionPressed: () => _calendarStateService.getCalendar(),
    );
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    final state = _calendarStateService.stateNotifier.value;
    _calendarLoadState = state.loadState;
    _calendar = state.calendar;
    _calendarStateService.stateNotifier.addListener(_onCalendarStateChanged);
    _calendarStateService.getCalendar();
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _appLocalizations = context.locals.app;
    _toast = LmuToast.of(context);
  }

  @override
  void dispose() {
    _calendarStateService.stateNotifier.removeListener(_onCalendarStateChanged);
    super.dispose();
  }
}
