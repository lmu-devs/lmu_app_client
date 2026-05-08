class CalendarGenericException implements Exception {
  const CalendarGenericException([this.message = 'An unexpected error occurred.']);

  final String message;

  @override
  String toString() => 'Exception: $message';
}
