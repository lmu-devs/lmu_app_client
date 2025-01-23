import 'package:equatable/equatable.dart';

import '../../repository/api/models/sports_model.dart';

abstract class SportsState extends Equatable {
  const SportsState();

  @override
  List<Object> get props => [];
}

class SportsInitial extends SportsState {
  const SportsInitial();
}

class SportsLoadInProgress extends SportsState {
  const SportsLoadInProgress();
}

class SportsLoadSuccess extends SportsState {
  const SportsLoadSuccess({required this.sports});

  final List<SportsModel> sports;

  @override
  List<Object> get props => [sports];
}

class SportsLoadFailure extends SportsState {
  const SportsLoadFailure();
}
