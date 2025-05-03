import 'package:core_routes/cinema.dart';

import '../repository/api/api.dart';

class CinemaDetailsData extends RCinemaDetailsData {
  const CinemaDetailsData({required this.cinema, required this.screenings});

  final CinemaModel cinema;
  final List<ScreeningModel> screenings;

  @override
  List<Object?> get props => [cinema, screenings];
}
