import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../repository/cinema_repository.dart';
import 'cinema_state.dart';

class CinemaCubit extends Cubit<CinemaState> {
  CinemaCubit() : super(const CinemaInitial());

  final _repository = GetIt.I.get<CinemaRepository>();

  Future<void> loadCinemaData() async {
    final cachedCinemas = await _repository.getCachedCinemas();
    final cachedScreenings = await _repository.getCachedScreenings();
    emit(CinemaLoadInProgress(cinemas: cachedCinemas, screenings: cachedScreenings));

    final cinemas = await _repository.getCinemas();
    final screenings = await _repository.getScreenings();

    if (cinemas == null && screenings == null && cachedCinemas == null && cachedScreenings == null) {
      emit(const CinemaLoadFailure());
      return;
    }
    emit(CinemaLoadSuccess(cinemas: cinemas ?? cachedCinemas!, screenings: screenings ?? cachedScreenings!));
  }
}
