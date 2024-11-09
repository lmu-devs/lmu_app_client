import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mensa/src/repository/mensa_repository.dart';

import 'mensa_state.dart';

class MensaCubit extends Cubit<MensaState> {
  MensaCubit({
    required this.mensaRepository,
  }) : super(MensaInitial());

  final MensaRepository mensaRepository;

  void loadMensaData() async {
    emit(MensaLoadInProgress());

    try {
      await Future.delayed(const Duration(seconds: 2));
      final mensaModels = await mensaRepository.getMensaModels();

      emit(MensaLoadSuccess(mensaModels: mensaModels));
    } catch (e) {
      emit(MensaLoadFailure());
    }
  }
}
