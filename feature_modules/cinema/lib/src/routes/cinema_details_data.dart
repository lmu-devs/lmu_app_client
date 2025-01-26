import '../repository/api/api.dart';
import '../repository/api/models/screening_model.dart';

class CinemaDetailsData {
  final CinemaModel cinema;
  final List<ScreeningModel> screenings;

  CinemaDetailsData({
    required this.cinema,
    required this.screenings,
  });
}
