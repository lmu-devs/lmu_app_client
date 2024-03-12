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
      final result = await mensaRepository.getMensa();

      // Mock data loading delay
      await Future.delayed(const Duration(seconds: 1));

      emit(MensaLoadSuccess(mensaData: result));
    } catch (e) {
      emit(MensaLoadFailure());
    }
  }
}
