import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../repository/mensa_repository.dart';
import 'mensa_state.dart';

class MensaCubit extends Cubit<MensaState> {
  MensaCubit() : super(MensaInitial());

  final _mensaRepository = GetIt.I.get<MensaRepository>();

  void loadMensaData() async {
    emit(MensaLoadInProgress());

    try {
      final mensaModels = await _mensaRepository.getMensaModels();

      emit(MensaLoadSuccess(mensaModels: mensaModels));
    } catch (e) {
      emit(MensaLoadFailure());
    }
  }
}
