class LibrariesApiEndpoints {
  static const String _libraryRoute = '/library';

  static const String _librariesRoute = '/libraries';

  static String getLibraries({String? id}) {
    final query = id == null ? '' : '?id=$id';
    return '$_libraryRoute$_librariesRoute$query';
  }
}
