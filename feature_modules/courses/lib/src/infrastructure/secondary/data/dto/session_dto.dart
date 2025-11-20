import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/model/session_model.dart';

part 'session_dto.g.dart';

@JsonSerializable()
class SessionDto extends Equatable {
  const SessionDto({
    required this.caption,
    required this.startingTime,
    required this.endingTime,
    required this.rhythm,
    this.weekday,
    this.timingType,
    this.durationStart,
    this.durationEnd,
    this.room,
    this.lecturer,
    this.remark,
    this.cancelledDates,
  });

  factory SessionDto.fromJson(Map<String, dynamic> json) =>
      _$SessionDtoFromJson(json);

  final String caption;
  final String? weekday;
  @JsonKey(name: 'starting_time')
  final String startingTime;
  @JsonKey(name: 'ending_time')
  final String endingTime;
  @JsonKey(name: 'timing_type')
  final String? timingType;
  @JsonKey(name: 'rhythm')
  final String rhythm;
  @JsonKey(name: 'duration_start')
  final String? durationStart;
  @JsonKey(name: 'duration_end')
  final String? durationEnd;
  final String? room;
  final String? lecturer;
  final String? remark;
  @JsonKey(name: 'cancelled_dates')
  final String? cancelledDates;

  /// DTO → Domain
  @JsonKey(includeFromJson: false, includeToJson: false)
  SessionModel toDomain() => SessionModel(
    caption: caption,
    weekday: weekday,
    startingTime: startingTime,
    endingTime: endingTime,
    timingType: timingType,
    rhythm: rhythm,
    durationStart: durationStart,
    durationEnd: durationEnd,
    room: room,
    lecturer: lecturer,
    remark: remark,
    cancelledDates: cancelledDates,
  );

  Map<String, dynamic> toJson() => _$SessionDtoToJson(this);

  @override
  List<Object?> get props => [
    caption,
    weekday,
    startingTime,
    endingTime,
    timingType,
    rhythm,
    durationStart,
    durationEnd,
    room,
    lecturer,
    remark,
    cancelledDates,
  ];
}
