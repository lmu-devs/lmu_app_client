import 'package:equatable/equatable.dart';

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
    required this.mensaData,
  });

  final String mensaData;

  @override
  List<Object?> get props => [mensaData];
}

class MensaLoadFailure extends MensaState {
  @override
  List<Object?> get props => [];
}
