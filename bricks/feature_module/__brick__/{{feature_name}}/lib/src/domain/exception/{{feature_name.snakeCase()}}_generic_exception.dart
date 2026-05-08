class {{feature_name.pascalCase()}}GenericException implements Exception {
  const {{feature_name.pascalCase()}}GenericException([this.message = 'An unexpected error occurred.']);

  final String message;

  @override
  String toString() => 'Exception: $message';
}
