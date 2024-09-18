import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mensa_day_hours.g.dart';

@JsonSerializable()
class MensaDayHours extends Equatable {
  const MensaDayHours({
    required this.start,
    required this.end,
  });

  @JsonKey(name: 'start_time')
  final String start;
  @JsonKey(name: 'end_time')
  final String end;

  factory MensaDayHours.fromJson(Map<String, dynamic> json) => _$MensaDayHoursFromJson(json);

  Map<String, dynamic> toJson() => _$MensaDayHoursToJson(this);

  @override
  List<Object?> get props => [
        start,
        end,
      ];
}
