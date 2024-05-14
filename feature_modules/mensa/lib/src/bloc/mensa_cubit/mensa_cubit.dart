import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/mensa_repository.dart';
import 'mensa_state.dart';

class MensaCubit extends Cubit<MensaState> {
  MensaCubit({
    required this.mensaRepository,
  }) : super(MensaInitial());

  final MensaRepository mensaRepository;

  void loadMensaData() async {
    emit(MensaLoadInProgress());

    try {
      final mensaModels = await mensaRepository.getMensaOverview();

      emit(MensaLoadSuccess(mensaModels: mensaModels));
    } catch (e) {
      emit(MensaLoadFailure());
    }
  }
}
