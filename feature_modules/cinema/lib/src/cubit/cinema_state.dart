import 'package:core/utils.dart';
import 'package:equatable/equatable.dart';

import '../repository/api/api.dart';

abstract class CinemaState extends Equatable {
  const CinemaState();

  @override
  List<Object> get props => [];
}

class CinemaInitial extends CinemaState {
  const CinemaInitial();
}

class CinemaLoadInProgress extends CinemaState {
  const CinemaLoadInProgress({this.cinemas, this.screenings});

  final List<CinemaModel>? cinemas;
  final List<ScreeningModel>? screenings;
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
  const CinemaLoadFailure({this.loadState = LoadState.genericError});

  final LoadState loadState;

  @override
  List<Object> get props => [loadState];
}
