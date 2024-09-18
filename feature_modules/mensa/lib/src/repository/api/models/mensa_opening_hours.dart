import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mensa_opening_hours.g.dart';

@JsonSerializable()
class MensaOpeningHours extends Equatable {
  const MensaOpeningHours({
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  final String day;
  @JsonKey(name: 'start_time')
  final String startTime;
  @JsonKey(name: 'end_time')
  final String endTime;

  factory MensaOpeningHours.fromJson(Map<String, dynamic> json) => _$MensaOpeningHoursFromJson(json);

  Map<String, dynamic> toJson() => _$MensaOpeningHoursToJson(this);

  @override
  List<Object?> get props => [
        day,
        startTime,
        endTime,
      ];
}
