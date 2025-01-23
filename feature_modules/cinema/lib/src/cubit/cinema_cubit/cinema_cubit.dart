import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'cinema_state.dart';
import '../../repository/cinema_repository.dart';

class CinemaCubit extends Cubit<CinemaState> {
  CinemaCubit() : super(const CinemaInitial());

  final _repository = GetIt.I.get<CinemaRepository>();

  Future<void> loadCinema() async {
    emit(const CinemaLoadInProgress());
    
    try {
      final data = await _repository.getCinema();
      emit(CinemaLoadSuccess(data: data));
    } catch (e) {
      emit(const CinemaLoadFailure());
    }
  }
}
