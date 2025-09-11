import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/model/lecture.dart';

part 'lectures_dto.g.dart';

@JsonSerializable()
class LecturesDto extends Equatable {
  const LecturesDto({
    required this.id,
    required this.title,
    required this.tags,
    required this.facultyId,
    this.description,
    this.credits,
    this.semester,
  });

  factory LecturesDto.fromJson(Map<String, dynamic> json) => _$LecturesDtoFromJson(json);

  final String id;
  final String title;
  final List<String> tags;
  final int facultyId;
  final String? description;
  final int? credits;
  final String? semester;

  // Convert single DTO to single domain object
  Lecture toDomain() => Lecture(
        id: id,
        title: title,
        tags: tags,
        facultyId: facultyId,
        description: description,
        credits: credits,
        semester: semester,
      );

  // Convert list of DTOs to list of domain objects
  static List<Lecture> toDomainList(List<LecturesDto> dtos) {
    return dtos.map((dto) => dto.toDomain()).toList();
  }

  Map<String, dynamic> toJson() => _$LecturesDtoToJson(this);

  @override
  List<Object?> get props => [id, title, tags, facultyId, description, credits, semester];
}
