import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../repository/mensa_repository.dart';
import 'taste_profile_state.dart';

class TasteProfileCubit extends Cubit<TasteProfileState> {
  TasteProfileCubit() : super(TasteProfileInitial());

  final _mensaRepository = GetIt.I.get<MensaRepository>();

  Future<void> loadTasteProfile() async {
    try {
      final tasteProfile = await _mensaRepository.getTasteProfileContent();
      emit(TasteProfileLoadSuccess(tasteProfile));
    } catch (e) {
      print('Error loading taste profile: $e');
      emit(TasteProfileLoadFailure());
    }
  }
}