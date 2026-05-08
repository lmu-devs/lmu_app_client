class PeopleGenericException implements Exception {
  const PeopleGenericException([this.message = 'An unexpected error occurred.']);

  final String message;

  @override
  String toString() => 'Exception: $message';
}
