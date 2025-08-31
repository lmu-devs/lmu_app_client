import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_dto.g.dart';

@JsonSerializable()
class CourseDto extends Equatable {
  const CourseDto({
    required this.id,
    required this.name,
    required this.facultyId,
    this.description,
    this.credits,
    this.semester,
  });

  factory CourseDto.fromJson(Map<String, dynamic> json) => _$CourseDtoFromJson(json);

  final String id;
  final String name;
  final int facultyId;
  final String? description;
  final int? credits;
  final String? semester;

  Map<String, dynamic> toJson() => _$CourseDtoToJson(this);

  @override
  List<Object?> get props => [id, name, facultyId, description, credits, semester];
}
