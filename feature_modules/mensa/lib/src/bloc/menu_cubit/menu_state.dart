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
    required this.menuModels,
  });

  final List<MenuDayModel> menuModels;

  @override
  List<Object?> get props => [menuModels];
}

class MenuLoadFailure extends MenuState {
  @override
  List<Object?> get props => [];
}
