import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time_period_model.g.dart';

@JsonSerializable()
class TimePeriodModel extends Equatable {
  @JsonKey(name: 'start_date')
  final DateTime startDate;
  @JsonKey(name: 'end_date')
  final DateTime endDate;

  const TimePeriodModel({
    required this.startDate,
    required this.endDate,
  });



  factory TimePeriodModel.fromJson(Map<String, dynamic> json) => _$TimePeriodModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimePeriodModelToJson(this);

  @override
  List<Object?> get props => [
        startDate,
        endDate,
      ];
}