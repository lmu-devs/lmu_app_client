import '../repository/api/api.dart';

CinemaModel getCinemaForScreening(List<CinemaModel> cinemas, String cinemaId) {
  return cinemas.firstWhere((cinema) => cinema.id == cinemaId);
}

List<ScreeningModel> getScreeningsForCinema(List<ScreeningModel> screenings, String cinemaId) {
  return screenings.where((screening) => screening.cinemaId == cinemaId).toList();
}
