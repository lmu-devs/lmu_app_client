class CinemaApiEndpoints {
  static const String _cinemaRoute = '/cinema';

  static const String _cinemasRoute = '/cinemas';
  static const String _moviesRoute = '/movies';
  static const String _screeningsRoute = '/screenings';

  static String getCinemas({int? id}) {
    final query = id == null ? '' : '?id=$id';
    return '$_cinemaRoute$_cinemasRoute$query';
  }

  static String getMovies() {
    return '$_cinemaRoute$_moviesRoute';
  }

  static String getScreenings() {
    return '$_cinemaRoute$_screeningsRoute';
  }
}
