import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../repository/mensa_repository.dart';
import 'taste_profile_state.dart';

class TasteProfileCubit extends Cubit<TasteProfileState> {
  TasteProfileCubit() : super(TasteProfileInitial());

  final _mensaRepository = GetIt.I.get<MensaRepository>();

  Future<void> loadTasteProfile({bool forceRefresh = false}) async {
    emit(TasteProfileLoadInProgress());
    try {
      final tasteProfile = await _mensaRepository.getTasteProfileContent(forceRefresh: forceRefresh);
      emit(TasteProfileLoadSuccess(tasteProfile));
    } catch (e) {
      emit(TasteProfileLoadFailure());
    }
  }

  void resetTasteProfile() {
    loadTasteProfile(forceRefresh: true);
  }
}
