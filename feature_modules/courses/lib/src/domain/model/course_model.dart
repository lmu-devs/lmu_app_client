import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_model.g.dart';

@JsonSerializable()
class CourseModel extends Equatable {
  const CourseModel({
    required this.publishId,
    required this.name,
    required this.type,
    required this.language,
    this.degree,
    this.sws,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => _$CourseModelFromJson(json);

  @JsonKey(name: 'publish_id')
  final int publishId;
  final String name;
  final String? degree;
  final int? sws;
  final String type;
  final String language;

  @override
  List<Object?> get props => [
    publishId,
    name,
    degree,
    sws,
    type,
    language,
  ];

  Map<String, dynamic> toJson() => _$CourseModelToJson(this);
}
