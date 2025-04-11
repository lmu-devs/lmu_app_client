import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../repository/timeline_repository.dart';
import 'timeline_state.dart';

class TimelineCubit extends Cubit<TimelineState> {
  TimelineCubit() : super(const TimelineInitial());

  final _repository = GetIt.I.get<TimelineRepository>();

  Future<void> loadTimeline() async {
    final cachedData = await _repository.getCachedTimeline();
    emit(TimelineLoadInProgress(data: cachedData));

    final data = await _repository.getTimeline();
    if (data == null && cachedData == null) {
      emit(const TimelineLoadFailure());
      return;
    }
    emit(TimelineLoadSuccess(data: data ?? cachedData!));
  }
}
