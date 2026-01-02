import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'semester_model.g.dart';

@JsonSerializable()
class SemesterModel extends Equatable {
  const SemesterModel({
    required this.year,
    required this.semesterType,
  });

  factory SemesterModel.fromJson(Map<String, dynamic> json) => _$SemesterModelFromJson(json);

  final int year;
  @JsonKey(name: 'semester_type')
  final String semesterType;

  @override
  List<Object?> get props => [
    year,
    semesterType,
  ];

  Map<String, dynamic> toJson() => _$SemesterModelToJson(this);
}

