import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/model/grade.dart';

part 'grade_dto.g.dart';

@JsonSerializable()
class GradeDto extends Equatable {
  const GradeDto({
    required this.id,
    required this.name,
    required this.ects,
    required this.grade,
    required this.semester,
  });

  final String id;
  final String name;
  final int ects;
  final double grade;
  final String semester;

  Grade toDomain() => Grade(
        id: id,
        name: name,
        ects: ects,
        grade: grade,
        semester: GradeSemesterExtension.fromJsonString(semester),
      );

  factory GradeDto.fromDomain(Grade grade) => GradeDto(
        id: grade.id,
        name: grade.name,
        ects: grade.ects,
        grade: grade.grade,
        semester: grade.semester.toJsonString(),
      );

  factory GradeDto.fromJson(Map<String, dynamic> json) => _$GradeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GradeDtoToJson(this);

  @override
  List<Object?> get props => [id, name];
}

extension GradeSemesterExtension on GradeSemester {
  String toJsonString() {
    switch (this) {
      case GradeSemester.winter2020:
        return 'winter2020';
      case GradeSemester.summer2021:
        return 'summer2021';
      case GradeSemester.winter2021:
        return 'winter2021';
      case GradeSemester.summer2022:
        return 'summer2022';
      case GradeSemester.winter2022:
        return 'winter2022';
      case GradeSemester.summer2023:
        return 'summer2023';
      case GradeSemester.winter2023:
        return 'winter2023';
      case GradeSemester.summer2024:
        return 'summer2024';
      case GradeSemester.winter2024:
        return 'winter2024';
      case GradeSemester.summer2025:
        return 'summer2025';
      case GradeSemester.winter2025:
        return 'winter2025';
    }
  }

  static GradeSemester fromJsonString(String semester) {
    switch (semester) {
      case 'winter2020':
        return GradeSemester.winter2020;
      case 'summer2021':
        return GradeSemester.summer2021;
      case 'winter2021':
        return GradeSemester.winter2021;
      case 'summer2022':
        return GradeSemester.summer2022;
      case 'winter2022':
        return GradeSemester.winter2022;
      case 'summer2023':
        return GradeSemester.summer2023;
      case 'winter2023':
        return GradeSemester.winter2023;
      case 'summer2024':
        return GradeSemester.summer2024;
      case 'winter2024':
        return GradeSemester.winter2024;
      case 'summer2025':
        return GradeSemester.summer2025;
      case 'winter2025':
        return GradeSemester.winter2025;
      default:
        throw ArgumentError('Unknown semester string: $semester');
    }
  }
}
