class BenefitsGenericException implements Exception {
  const BenefitsGenericException([this.message = 'An unexpected error occurred.']);

  final String message;

  @override
  String toString() => 'Exception: $message';
}
