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

    final sports = await _repository.getSports();
    if (sports == null && cachedData == null) {
      emit(const SportsLoadFailure());
      return;
    }
    emit(SportsLoadSuccess(sports: sports ?? cachedData!));
  }
}
