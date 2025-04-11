import 'package:core/extensions.dart';
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

    final mensaModels = await _mensaRepository.getMensaModels();
    if (mensaModels == null && cachedData == null) {
      emit(MensaLoadFailure());
      listenForConnectivityRestoration(loadMensaData);
      return;
    }

    emit(MensaLoadSuccess(mensaModels: mensaModels ?? cachedData!));
  }
}
