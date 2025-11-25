class CalendarApiEndpoints {
  static const _calendarRoute = '/calendar';

  static const String _userEventRoute = '/user-event';
  static const String _getRoute = '/get';

  // user-event endpoint for personal events (POST)
  static String createCalendarEntry() => '$_calendarRoute$_userEventRoute'; // Formerly '/calendar-create'

  // user-event endpoint for personal events (DELETE)
  static String deleteCalendarEntry() => '$_calendarRoute$_userEventRoute'; // Formerly '/calendar-delete'

  // user-event endpoint for personal events (PUT)
  static String updateCalendarEntry() => '$_calendarRoute$_userEventRoute'; // Formerly '/calendar-update'

  static String getCalendarEntries({
    String? eventType,
    String? frequency,
    bool? allDay,
    // FastAPI also supports 'access_scope' as a query parameter - maybe later
  }) {
    final queryParams = <String, dynamic>{};
    if (eventType != null) queryParams['event_type'] = eventType;
    if (frequency != null) queryParams['frequency'] = frequency;
    if (allDay != null) queryParams['all_day'] = allDay.toString();

    if (queryParams.isEmpty) {
      return '$_calendarRoute$_getRoute';
    } else {
      final uri = Uri(path: '$_calendarRoute$_getRoute', queryParameters: queryParams);
      return uri.toString();
    }
  }
}
