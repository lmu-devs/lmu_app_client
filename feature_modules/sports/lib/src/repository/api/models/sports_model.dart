import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'sports_course.dart';

part 'sports_model.g.dart';

@JsonSerializable()
class SportsModel extends Equatable {
  const SportsModel({
    required this.title,
    required this.courses,
  });

  final String title;
  final List<SportsCourse> courses;

  factory SportsModel.fromJson(Map<String, dynamic> json) => _$SportsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SportsModelToJson(this);

  @override
  List<Object?> get props => [title, courses];
}
