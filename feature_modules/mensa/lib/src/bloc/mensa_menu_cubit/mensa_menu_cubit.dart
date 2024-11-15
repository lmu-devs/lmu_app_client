import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/mensa_repository.dart';
import 'mensa_menu_state.dart';

class MensaMenuCubit extends Cubit<MensaMenuState> {
  MensaMenuCubit({
    required this.mensaRepository,
  }) : super(MensaMenuInitial());

  final MensaRepository mensaRepository;

  void loadMensaMenuData(String canteenId, int year, String week, bool liked) async {
    emit(MensaMenuLoadInProgress());

    try {
      final mensaMenuModels = await mensaRepository.getMensaMenusForSpecificWeek(canteenId, year, week, liked);

      emit(MensaMenuLoadSuccess(mensaMenuModels: mensaMenuModels));
    } catch (e) {
      emit(MensaMenuLoadFailure());
    }
  }
}
