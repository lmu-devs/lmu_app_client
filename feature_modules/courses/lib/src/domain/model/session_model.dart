import 'package:core_routes/courses.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session_model.g.dart';

@JsonSerializable()
class SessionModel extends Equatable implements RSessionModel {
  const SessionModel({
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

  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);

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

  Map<String, dynamic> toJson() => _$SessionModelToJson(this);
}
