import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/model/faculty.dart';

part 'faculty_dto.g.dart';

@JsonSerializable()
class FacultyDto extends Equatable {
  const FacultyDto({
    required this.id,
    required this.name,
  });

  factory FacultyDto.fromJson(Map<String, dynamic> json) => _$FacultyDtoFromJson(json);

  final int id;
  final String name;

  FacultyImpl toDomain() => FacultyImpl(
        id: id,
        name: name,
      );

  Map<String, dynamic> toJson() => _$FacultyDtoToJson(this);

  @override
  List<Object?> get props => [id, name];
}
