class CalendarApiEndpoints {
  static String createCalendarEntry() => '/calendar-create';
  static String deleteCalendarEntry() => '/calendar-delete';
  static String updateCalendarEntry() => '/calendar-update';
  static String getCalendarEntries({
    String? eventType,
    String? frequency,
    bool? allDay,
  }) {
    final queryParams = <String, dynamic>{};
    if (eventType != null) queryParams['event_type'] = eventType;
    if (frequency != null) queryParams['frequency'] = frequency;
    if (allDay != null) queryParams['all_day'] = allDay.toString();

    if (queryParams.isEmpty) {
      return '/calendar-get';
    } else {
      final uri = Uri(path: '/calendar-get', queryParameters: queryParams);
      return uri.toString(); // "/calendar-get?..."
    }
  }
}
