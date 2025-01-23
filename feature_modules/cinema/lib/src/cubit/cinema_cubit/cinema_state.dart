import 'package:equatable/equatable.dart';

import '../../repository/api/models/cinema_model.dart';

abstract class CinemaState extends Equatable{
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
  const CinemaLoadSuccess({required this.data});

  final CinemaModel data;

  @override
  List<Object> get props => [data];
}

class CinemaLoadFailure extends CinemaState {
  const CinemaLoadFailure();
}