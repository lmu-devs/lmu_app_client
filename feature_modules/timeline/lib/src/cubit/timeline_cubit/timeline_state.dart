import 'package:equatable/equatable.dart';

import '../../repository/api/models/timeline_data.dart';

abstract class TimelineState extends Equatable {
  const TimelineState();

  @override
  List<Object> get props => [];
}

class TimelineInitial extends TimelineState {
  const TimelineInitial();
}

class TimelineLoadInProgress extends TimelineState {
  const TimelineLoadInProgress();
}

class TimelineLoadSuccess extends TimelineState {
  const TimelineLoadSuccess({required this.data});

  final TimelineData data;

  @override
  List<Object> get props => [data];
}

class TimelineLoadFailure extends TimelineState {
  const TimelineLoadFailure();
}
