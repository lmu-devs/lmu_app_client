import '../repository/api/api.dart';

class ScreeningDetailsData {
  final ScreeningModel screening;
  final List<ScreeningModel> cinemaScreenings;

  ScreeningDetailsData({
    required this.screening,
    required this.cinemaScreenings,
  });
}
