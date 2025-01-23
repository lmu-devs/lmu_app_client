import 'package:core/api.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sports_time_slot.g.dart';

@JsonSerializable()
class SportsTimeSlot extends Equatable {
  const SportsTimeSlot({
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  final Weekday day;
  @JsonKey(name: 'start_time')
  final String startTime;
  @JsonKey(name: 'end_time')
  final String endTime;

  factory SportsTimeSlot.fromJson(Map<String, dynamic> json) => _$SportsTimeSlotFromJson(json);

  Map<String, dynamic> toJson() => _$SportsTimeSlotToJson(this);

  @override
  List<Object?> get props => [day, startTime, endTime];
}
