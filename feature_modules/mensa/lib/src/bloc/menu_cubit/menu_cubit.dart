import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../repository/mensa_repository.dart';
import 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit({
    required String canteenId,
  })  : _canteenId = canteenId,
        super(MenuInitial()) {
    loadMensaMenuData();
  }

  final String _canteenId;
  final MensaRepository _mensaRepository = GetIt.I.get<MensaRepository>();

  void loadMensaMenuData() async {
    emit(MenuLoadInProgress());

    try {
      final mensaMenuModels = await _mensaRepository.getMenuDayForMensa(_canteenId);

      emit(MenuLoadSuccess(menuModels: mensaMenuModels));
    } catch (_) {
      emit(MenuLoadFailure());
    }
  }
}
