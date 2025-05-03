import 'package:core_routes/cinema.dart';

import '../repository/api/api.dart';

class ScreeningsHistoryData extends RScreeningsHistoryData {
  const ScreeningsHistoryData({required this.cinemas, required this.screenings});

  final List<CinemaModel> cinemas;
  final List<ScreeningModel> screenings;

  @override
  List<Object> get props => [cinemas, screenings];
}
