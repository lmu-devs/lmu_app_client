class StudiesGenericException implements Exception {
  const StudiesGenericException([this.message = 'An unexpected error occurred.']);

  final String message;

  @override
  String toString() => 'Exception: $message';
}
