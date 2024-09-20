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
    required this.mensaMenuModel,
  });

  final MensaMenuWeekModel mensaMenuModel;

  @override
  List<Object?> get props => [mensaMenuModel];
}

class MensaMenuLoadFailure extends MensaMenuState {
  @override
  List<Object?> get props => [];
}
