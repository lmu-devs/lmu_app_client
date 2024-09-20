import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mensa/src/repository/mensa_repository.dart';
import 'mensa_menu_state.dart';

class MensaMenuCubit extends Cubit<MensaMenuState> {
  MensaMenuCubit({
    required this.mensaRepository,
  }) : super(MensaMenuInitial());

  final MensaRepository mensaRepository;

  void loadMensaMenuData(String canteenId, int year, String week) async {
    emit(MensaMenuLoadInProgress());

    try {
      final mensaMenuModel = await mensaRepository.getMensaMenuForSpecificWeek(canteenId, year, week);

      emit(MensaMenuLoadSuccess(mensaMenuModel: mensaMenuModel));
    } catch (e) {
      emit(MensaMenuLoadFailure());
    }
  }
}
