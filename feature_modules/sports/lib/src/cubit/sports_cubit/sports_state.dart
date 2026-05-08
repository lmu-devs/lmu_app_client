import 'package:core/utils.dart';
import 'package:equatable/equatable.dart';

import '../../repository/api/api.dart';

abstract class SportsState extends Equatable {
  const SportsState();

  @override
  List<Object?> get props => [];
}

class SportsInitial extends SportsState {
  const SportsInitial();
}

class SportsLoadInProgress extends SportsState {
  const SportsLoadInProgress({this.sports});

  final SportsModel? sports;

  @override
  List<Object?> get props => [sports];
}

class SportsLoadSuccess extends SportsState {
  const SportsLoadSuccess({required this.sports});

  final SportsModel sports;

  @override
  List<Object> get props => [sports];
}

class SportsLoadFailure extends SportsState {
  const SportsLoadFailure({this.loadState = LoadState.genericError});

  final LoadState loadState;

  @override
  List<Object> get props => [loadState];
}
