import 'package:equatable/equatable.dart';

import '../../repository/api/models/cinema_model.dart';
import '../../repository/api/models/screening_model.dart';

abstract class CinemaState extends Equatable {
  const CinemaState();

  @override
  List<Object> get props => [];
}

class CinemaInitial extends CinemaState {
  const CinemaInitial();
}

class CinemaLoadInProgress extends CinemaState {
  const CinemaLoadInProgress();
}

class CinemaLoadSuccess extends CinemaState {
  const CinemaLoadSuccess({
    required this.cinemas,
    required this.screenings,
  });

  final List<CinemaModel> cinemas;
  final List<ScreeningModel> screenings;

  @override
  List<Object> get props => [
        cinemas,
        screenings,
      ];
}

class CinemaLoadFailure extends CinemaState {
  const CinemaLoadFailure();
}
