import 'package:equatable/equatable.dart';

import '../../repository/api/models/mensa/mensa_model.dart';

abstract class MensaState extends Equatable {}

class MensaInitial extends MensaState {
  @override
  List<Object?> get props => [];
}

class MensaLoadInProgress extends MensaState {
  @override
  List<Object?> get props => [];
}

class MensaLoadSuccess extends MensaState {
  MensaLoadSuccess({
    required this.mensaModels,
  });

  final List<MensaModel> mensaModels;

  @override
  List<Object?> get props => [mensaModels];
}

class MensaLoadFailure extends MensaState {
  @override
  List<Object?> get props => [];
}
