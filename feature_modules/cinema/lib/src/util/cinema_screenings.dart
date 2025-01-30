import '../repository/api/api.dart';

List<ScreeningModel> getScreeningsForCinema(List<ScreeningModel> screenings, String cinemaId) {
  return screenings.where((screening) => screening.cinema.id == cinemaId).toList();
}