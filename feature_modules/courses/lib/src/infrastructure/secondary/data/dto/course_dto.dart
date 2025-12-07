import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/model/course_model.dart';

part 'course_dto.g.dart';

@JsonSerializable()
class CourseDto extends Equatable {
  const CourseDto({
    required this.publishId,
    required this.name,
    required this.type,
    required this.language,
    this.degree,
    this.sws,
  });

  factory CourseDto.fromJson(Map<String, dynamic> json) =>
      _$CourseDtoFromJson(json);

  @JsonKey(name: 'publish_id')
  final int publishId;
  final String name;
  final String? degree;
  final int? sws;
  final String type;
  final String language;

  /// Convert DTO → Domain Model
  @JsonKey(includeFromJson: false, includeToJson: false)
  CourseModel toDomain() => CourseModel(
    publishId: publishId,
    name: name,
    degree: degree,
    sws: sws,
    type: type,
    language: language,
  );

  Map<String, dynamic> toJson() => _$CourseDtoToJson(this);

  @override
  List<Object?> get props => [
    publishId,
    name,
    degree,
    sws,
    type,
    language,
  ];
}
