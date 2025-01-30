import '../repository/api/api.dart';

class CinemaDetailsData {
  final CinemaModel cinema;
  final List<ScreeningModel> screenings;

  CinemaDetailsData({
    required this.cinema,
    required this.screenings,
  });
}
