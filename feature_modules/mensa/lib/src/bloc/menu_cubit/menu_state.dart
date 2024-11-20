import 'package:equatable/equatable.dart';

import '../../repository/api/models/menu/menu_day_model.dart';

abstract class MenuState extends Equatable {}

class MenuInitial extends MenuState {
  @override
  List<Object?> get props => [];
}

class MenuLoadInProgress extends MenuState {
  @override
  List<Object?> get props => [];
}

class MenuLoadSuccess extends MenuState {
  MenuLoadSuccess({
    required this.mensaMenuModels,
  });

  final List<MenuDayModel> mensaMenuModels;

  @override
  List<Object?> get props => [mensaMenuModels];
}

class MenuLoadFailure extends MenuState {
  @override
  List<Object?> get props => [];
}
