class CalendarEntriesGenericException implements Exception {
  const CalendarEntriesGenericException([this.message = 'An unexpected error occurred.']);

  final String message;

  @override
  String toString() => 'Exception: $message';
}
