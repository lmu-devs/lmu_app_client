import 'package:core_routes/cinema.dart';

import '../repository/api/api.dart';

class ScreeningDetailsData extends RScreeningDetailsData {
  const ScreeningDetailsData({required this.cinema, required this.screening, required this.cinemaScreenings});

  final CinemaModel cinema;
  final ScreeningModel screening;
  final List<ScreeningModel> cinemaScreenings;

  @override
  List<Object?> get props => [cinema, screening, cinemaScreenings];
}
