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
  const RoomfinderLoadSuccess({required this.cities});

  final List<RoomfinderCity> cities;

  @override
  List<Object> get props => [cities];
}

class RoomfinderLoadFailure extends RoomfinderState {
  const RoomfinderLoadFailure();
}
