import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'semester_model.dart';

part 'available_semesters_model.g.dart';

@JsonSerializable()
class AvailableSemestersModel extends Equatable {
  const AvailableSemestersModel({
    required this.semesters,
    required this.currentSemester,
  });

  factory AvailableSemestersModel.fromJson(Map<String, dynamic> json) => _$AvailableSemestersModelFromJson(json);

  final List<SemesterModel> semesters;
  @JsonKey(name: 'current_semester')
  final SemesterModel currentSemester;

  @override
  List<Object?> get props => [
    semesters,
    currentSemester,
  ];

  Map<String, dynamic> toJson() => _$AvailableSemestersModelToJson(this);
}



