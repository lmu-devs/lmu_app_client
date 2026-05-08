import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/model/semester_model.dart';

part 'semester_dto.g.dart';

@JsonSerializable()
class SemesterDto extends Equatable {
  const SemesterDto({
    required this.year,
    required this.semesterType,
  });

  factory SemesterDto.fromJson(Map<String, dynamic> json) =>
      _$SemesterDtoFromJson(json);

  final int year;
  @JsonKey(name: 'semester_type')
  final String semesterType;

  /// DTO → Domain
  @JsonKey(includeFromJson: false, includeToJson: false)
  SemesterModel toDomain() => SemesterModel(
    year: year,
    semesterType: semesterType,
  );

  Map<String, dynamic> toJson() => _$SemesterDtoToJson(this);

  @override
  List<Object?> get props => [
    year,
    semesterType,
  ];
}
