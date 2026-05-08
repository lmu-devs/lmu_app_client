import 'package:core/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../repository/sports_repository.dart';
import 'sports_state.dart';

class SportsCubit extends Cubit<SportsState> {
  SportsCubit() : super(const SportsInitial());

  final _repository = GetIt.I.get<SportsRepository>();

  Future<void> loadSports() async {
    emit(const SportsLoadInProgress());

    final cachedData = await _repository.getCachedSports();
    emit(SportsLoadInProgress(sports: cachedData));

    try {
      final sports = await _repository.getSports();
      emit(SportsLoadSuccess(sports: sports));
    } catch (e) {
      if (cachedData != null) {
        emit(SportsLoadSuccess(sports: cachedData));
      } else {
        if (e is NoNetworkException) {
          emit(const SportsLoadFailure(loadState: LoadState.noNetworkError));
        } else {
          emit(const SportsLoadFailure(loadState: LoadState.genericError));
        }
      }
    }
  }
}
