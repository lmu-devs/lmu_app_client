class DeveloperdexGenericException implements Exception {
  const DeveloperdexGenericException([this.message = 'An unexpected error occurred.']);

  final String message;

  @override
  String toString() => 'Exception: $message';
}
