import '../repository/api/api.dart';

class ScreeningDetailsData {
  final CinemaModel cinema;
  final ScreeningModel screening;
  final List<ScreeningModel> cinemaScreenings;

  ScreeningDetailsData({
    required this.cinema,
    required this.screening,
    required this.cinemaScreenings,
  });
}
