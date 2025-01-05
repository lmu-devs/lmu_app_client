import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mensa_opening_details.g.dart';

enum Weekday {
  @JsonValue('MONDAY')
  monday,
  @JsonValue('TUESDAY')
  tuesday,
  @JsonValue('WEDNESDAY')
  wednesday,
  @JsonValue('THURSDAY')
  thursday,
  @JsonValue('FRIDAY')
  friday,
  @JsonValue('SATURDAY')
  saturday,
  @JsonValue('SUNDAY')
  sunday,
}

@JsonSerializable()
class MensaOpeningDetails extends Equatable {
  const MensaOpeningDetails({
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  final Weekday day;
  @JsonKey(name: 'start_time')
  final String startTime;
  @JsonKey(name: 'end_time')
  final String endTime;

  factory MensaOpeningDetails.fromJson(Map<String, dynamic> json) => _$MensaOpeningDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MensaOpeningDetailsToJson(this);

  @override
  List<Object?> get props => [
        day,
        startTime,
        endTime,
      ];
}
