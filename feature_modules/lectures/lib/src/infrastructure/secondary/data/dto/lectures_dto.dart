import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/model/lecture.dart';

part 'lectures_dto.g.dart';

@JsonSerializable()
class LecturesDto extends Equatable {
  const LecturesDto({
    required this.id,
    required this.name,
  });

  factory LecturesDto.fromJson(Map<String, dynamic> json) => _$LecturesDtoFromJson(json);

  final String id;
  final String name;

  // Convert single DTO to single domain object
  Lecture toDomain() => Lecture(
        id: id,
        title: name,
        tags: [],
        facultyId: 0, // Default faculty ID, should be updated when real API is implemented
      );

  // Convert list of DTOs to list of domain objects
  static List<Lecture> toDomainList(List<LecturesDto> dtos) {
    return dtos.map((dto) => dto.toDomain()).toList();
  }

  Map<String, dynamic> toJson() => _$LecturesDtoToJson(this);

  @override
  List<Object?> get props => [id, name];
}
