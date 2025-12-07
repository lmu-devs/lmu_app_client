import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/model/grade.dart';
import '../../../../domain/model/grade_semester.dart';

part 'grade_dto.g.dart';

@JsonSerializable()
class GradeDto extends Equatable {
  const GradeDto({
    required this.id,
    required this.name,
    required this.ects,
    required this.grade,
    required this.semester,
    this.isActive = true,
  });

  final String id;
  final String name;
  final int ects;
  final double? grade;
  final String semester;
  final bool isActive;

  Grade toDomain() => Grade(
        id: id,
        name: name,
        ects: ects,
        grade: grade,
        semester: GradeSemesterExtension.fromJsonString(semester),
        isActive: isActive,
      );

  factory GradeDto.fromDomain(Grade grade) => GradeDto(
        id: grade.id,
        name: grade.name,
        ects: grade.ects,
        grade: grade.grade,
        semester: grade.semester.toJsonString(),
        isActive: grade.isActive,
      );

  factory GradeDto.fromJson(Map<String, dynamic> json) => _$GradeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GradeDtoToJson(this);

  @override
  List<Object?> get props => [id, name];
}
