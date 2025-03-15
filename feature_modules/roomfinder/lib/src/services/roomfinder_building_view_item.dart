import 'package:equatable/equatable.dart';

class RoomfinderBuildingViewItem extends Equatable {
  const RoomfinderBuildingViewItem({
    required this.id,
    required this.title,
    this.distance,
  });

  final String id;
  final String title;
  final double? distance;

  @override
  List<Object?> get props => [id, title, distance];
}
