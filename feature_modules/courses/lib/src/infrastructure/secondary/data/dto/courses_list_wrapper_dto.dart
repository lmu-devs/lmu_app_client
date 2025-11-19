import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'course_dto.dart';

part 'courses_list_wrapper_dto.g.dart';

@JsonSerializable()
class CoursesListWrapperDto extends Equatable {
  const CoursesListWrapperDto({
    required this.courses,
    this.totalCount,
    this.pageSize,
    this.currentPage,
  });

  final List<CourseDto> courses;
  final int? totalCount;
  final int? pageSize;
  final int? currentPage;

  factory CoursesListWrapperDto.fromJson(Map<String, dynamic> json) => _$CoursesListWrapperDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CoursesListWrapperDtoToJson(this);

  @override
  List<Object?> get props => [courses, totalCount, pageSize, currentPage];
}
