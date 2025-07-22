import 'package:core/utils.dart';
import 'package:equatable/equatable.dart';

import '../../repository/api/models/models.dart';

abstract class RoomfinderState extends Equatable {
  const RoomfinderState();

  @override
  List<Object> get props => [];
}

class RoomfinderInitial extends RoomfinderState {
  const RoomfinderInitial();
}

class RoomfinderLoadInProgress extends RoomfinderState {
  const RoomfinderLoadInProgress();
}

class RoomfinderLoadSuccess extends RoomfinderState {
  const RoomfinderLoadSuccess({required this.streets});

  final List<RoomfinderStreet> streets;

  @override
  List<Object> get props => [streets];
}

class RoomfinderLoadFailure extends RoomfinderState {
  const RoomfinderLoadFailure({this.loadState = LoadState.genericError});

  final LoadState loadState;

  @override
  List<Object> get props => [loadState];
}
