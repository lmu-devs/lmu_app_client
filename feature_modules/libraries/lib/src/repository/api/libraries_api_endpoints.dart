class LibrariesApiEndpoints {
  static const String _libraryRoute = '/library';

  static const String _librariesRoute = '/libraries';

  static const String _toggleLike = '/toggle-like';
  static const String _libraryIdQuery = 'library_id';

  static String getLibraries({String? id}) {
    final query = id == null ? '' : '?id=$id';
    return '$_libraryRoute$_librariesRoute$query';
  }

  static String toggleFavoriteLibraryId(String id) {
    return '$_libraryRoute$_librariesRoute$_toggleLike?$_libraryIdQuery=$id';
  }
}
