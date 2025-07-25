import 'package:core/utils.dart';
import 'package:equatable/equatable.dart';

import '../../repository/api/models/mensa/mensa_model.dart';

abstract class MensaState extends Equatable {
  const MensaState();
}

class MensaInitial extends MensaState {
  @override
  List<Object?> get props => [];
}

class MensaLoadInProgress extends MensaState {
  const MensaLoadInProgress({this.mensaModels});

  final List<MensaModel>? mensaModels;

  @override
  List<Object?> get props => [];
}

class MensaLoadSuccess extends MensaState {
  const MensaLoadSuccess({required this.mensaModels});

  final List<MensaModel> mensaModels;

  @override
  List<Object?> get props => [mensaModels];
}

class MensaLoadFailure extends MensaState {
  const MensaLoadFailure({this.loadState = LoadState.genericError});

  final LoadState loadState;

  @override
  List<Object?> get props => [loadState];
}
