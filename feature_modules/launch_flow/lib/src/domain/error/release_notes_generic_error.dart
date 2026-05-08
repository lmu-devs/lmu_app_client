class ReleaseNotesGenericError implements Exception {
  const ReleaseNotesGenericError(this.message);

  final String message;

  @override
  String toString() => 'ReleaseNotesGenericError: $message';
}
