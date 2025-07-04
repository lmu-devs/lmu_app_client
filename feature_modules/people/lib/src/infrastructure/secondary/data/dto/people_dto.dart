import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/model/people.dart';

part 'people_dto.g.dart';

@JsonSerializable()
class PeopleDto extends Equatable {
  const PeopleDto({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  People toDomain() => People(
        id: id,
        name: name,
      );

  factory PeopleDto.fromJson(Map<String, dynamic> json) => _$PeopleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PeopleDtoToJson(this);

  @override
  List<Object?> get props => [id, name];
}
