import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/model/calendar.dart';

part 'calendar_dto.g.dart';

@JsonSerializable()
class CalendarDto extends Equatable {
  const CalendarDto({
    required this.id,
    required this.name,
  });

  factory CalendarDto.fromJson(Map<String, dynamic> json) => _$CalendarDtoFromJson(json);

  final String id;
  final String name;

  Calendar toDomain() => Calendar(
        id: id,
        name: name,
      );

  Map<String, dynamic> toJson() => _$CalendarDtoToJson(this);

  @override
  List<Object?> get props => [id, name];
}
