import 'package:core/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../repository/mensa_repository.dart';
import 'mensa_state.dart';

class MensaCubit extends Cubit<MensaState> {
  MensaCubit() : super(MensaInitial());

  final _mensaRepository = GetIt.I.get<MensaRepository>();

  void loadMensaData() async {
    final cachedData = await _mensaRepository.getCachedMensaModels();
    emit(MensaLoadInProgress(mensaModels: cachedData));

    try {
      final mensaModels = await _mensaRepository.getMensaModels();
      emit(MensaLoadSuccess(mensaModels: mensaModels));
    } catch (e) {
      if (cachedData != null) {
        emit(MensaLoadSuccess(mensaModels: cachedData));
      } else {
        if (e is NoNetworkException) {
          emit(const MensaLoadFailure(loadState: LoadState.noNetworkError));
        } else {
          emit(const MensaLoadFailure(loadState: LoadState.genericError));
        }
      }
    }
  }
}
