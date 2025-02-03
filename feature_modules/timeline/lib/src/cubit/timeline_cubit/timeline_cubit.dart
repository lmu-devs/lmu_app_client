import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'timeline_state.dart';
import '../../repository/timeline_repository.dart';

class TimelineCubit extends Cubit<TimelineState> {
  TimelineCubit() : super(const TimelineInitial());

  final _repository = GetIt.I.get<TimelineRepository>();

  Future<void> loadTimeline() async {
    emit(const TimelineLoadInProgress());

    try {
      final data = await _repository.getTimeline();
      emit(TimelineLoadSuccess(data: data));
    } catch (e) {
      emit(const TimelineLoadFailure());
    }
  }
}
