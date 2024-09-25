import 'package:equatable/equatable.dart';
import 'package:mensa/src/repository/api/models/mensa_menu_week_model.dart';

abstract class MensaMenuState extends Equatable {}

class MensaMenuInitial extends MensaMenuState {
  @override
  List<Object?> get props => [];
}

class MensaMenuLoadInProgress extends MensaMenuState {
  @override
  List<Object?> get props => [];
}

class MensaMenuLoadSuccess extends MensaMenuState {
  MensaMenuLoadSuccess({
    required this.mensaMenuModels,
  });

  final List<MensaMenuWeekModel> mensaMenuModels;

  @override
  List<Object?> get props => [mensaMenuModels];
}

class MensaMenuLoadFailure extends MensaMenuState {
  @override
  List<Object?> get props => [];
}
