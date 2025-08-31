import 'package:core/utils.dart';
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

    try {
      final cinemas = await _repository.getCinemas();
      final screenings = await _repository.getScreenings();

      emit(CinemaLoadSuccess(cinemas: cinemas, screenings: screenings));
    } catch (e) {
      if (cachedCinemas != null && cachedScreenings != null) {
        emit(CinemaLoadSuccess(cinemas: cachedCinemas, screenings: cachedScreenings));
      } else {
        if (e is NoNetworkException) {
          emit(const CinemaLoadFailure(loadState: LoadState.noNetworkError));
        } else {
          emit(const CinemaLoadFailure(loadState: LoadState.genericError));
        }
      }
    }
  }
}
