import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/model/lectures.dart';

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

  Lectures toDomain() => Lectures(
        id: id,
        name: name,
      );

  Map<String, dynamic> toJson() => _$LecturesDtoToJson(this);

  @override
  List<Object?> get props => [id, name];
}
