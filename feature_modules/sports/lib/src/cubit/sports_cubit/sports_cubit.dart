import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../repository/sports_repository.dart';
import 'sports_state.dart';

class SportsCubit extends Cubit<SportsState> {
  SportsCubit() : super(const SportsInitial());

  final _repository = GetIt.I.get<SportsRepository>();

  Future<void> loadSports() async {
    emit(const SportsLoadInProgress());

    try {
      final data = await _repository.getSports();
      emit(SportsLoadSuccess(sports: data));
    } catch (e) {
      emit(const SportsLoadFailure());
    }
  }
}
