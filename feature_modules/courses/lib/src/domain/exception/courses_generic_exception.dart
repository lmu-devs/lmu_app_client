class CoursesGenericException implements Exception {
  const CoursesGenericException([this.message = 'An unexpected error occurred.']);

  final String message;

  @override
  String toString() => 'Exception: $message';
}
