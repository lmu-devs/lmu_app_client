import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'cinema_state.dart';
import '../repository/cinema_repository.dart';

class CinemaCubit extends Cubit<CinemaState> {
  CinemaCubit() : super(const CinemaInitial());

  final _repository = GetIt.I.get<CinemaRepository>();

  Future<void> loadCinemaData() async {
    emit(const CinemaLoadInProgress());

    try {
      final cinemas = await _repository.getCinemas();
      final screenings = await _repository.getScreenings();
      emit(CinemaLoadSuccess(cinemas: cinemas, screenings: screenings));
    } catch (e) {
      emit(const CinemaLoadFailure());
    }
  }
}
