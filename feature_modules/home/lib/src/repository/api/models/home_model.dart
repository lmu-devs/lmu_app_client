import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'semester_fee_model.dart';
import 'time_period_model.dart';

part 'home_model.g.dart';

@JsonSerializable()
class HomeModel extends Equatable {
  @JsonKey(name: 'semester_fee')
  final SemesterFeeModel semesterFee;
  @JsonKey(name: 'lecture_free_time')
  final TimePeriodModel lectureFreeTime;
  @JsonKey(name: 'lecture_time')
  final TimePeriodModel lectureTime;

  const HomeModel({
    required this.semesterFee,
    required this.lectureFreeTime,
    required this.lectureTime,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => _$HomeModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeModelToJson(this);

  @override
  List<Object?> get props => [
        semesterFee,
        lectureFreeTime,
        lectureTime,
      ];
}
