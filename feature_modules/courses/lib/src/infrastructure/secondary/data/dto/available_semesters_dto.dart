import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/model/available_semesters_model.dart';
import 'semester_dto.dart';

part 'available_semesters_dto.g.dart';

@JsonSerializable()
class AvailableSemestersDto extends Equatable {
  const AvailableSemestersDto({
    required this.semesters,
    required this.currentSemester,
  });

  factory AvailableSemestersDto.fromJson(Map<String, dynamic> json) =>
      _$AvailableSemestersDtoFromJson(json);

  final List<SemesterDto> semesters;
  @JsonKey(name: 'current_semester')
  final SemesterDto currentSemester;

  /// DTO → Domain
  @JsonKey(includeFromJson: false, includeToJson: false)
  AvailableSemestersModel toDomain() => AvailableSemestersModel(
    semesters: semesters.map((semester) => semester.toDomain()).toList(),
    currentSemester: currentSemester.toDomain(),
  );

  Map<String, dynamic> toJson() => _$AvailableSemestersDtoToJson(this);

  @override
  List<Object?> get props => [
    semesters,
    currentSemester,
  ];
}
