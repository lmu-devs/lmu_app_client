class LecturesGenericException implements Exception {
  const LecturesGenericException([this.message = 'An unexpected error occurred.']);

  final String message;

  @override
  String toString() => 'Exception: $message';
}
