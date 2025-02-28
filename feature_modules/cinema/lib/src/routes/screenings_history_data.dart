import '../repository/api/api.dart';

class ScreeningsHistoryData {
  final List<CinemaModel> cinemas;
  final List<ScreeningModel> screenings;

  ScreeningsHistoryData({
    required this.cinemas,
    required this.screenings,
  });
}
