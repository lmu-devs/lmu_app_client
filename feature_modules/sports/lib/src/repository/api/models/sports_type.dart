import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'sports_course.dart';

part 'sports_type.g.dart';

@JsonSerializable()
class SportsType extends Equatable {
  const SportsType({
    required this.title,
    required this.courses,
  });

  final String title;
  final List<SportsCourse> courses;

  factory SportsType.fromJson(Map<String, dynamic> json) => _$SportsTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SportsTypeToJson(this);

  @override
  List<Object?> get props => [title, courses];
}
