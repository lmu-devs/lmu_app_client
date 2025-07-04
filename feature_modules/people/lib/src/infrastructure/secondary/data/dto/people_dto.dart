import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/model/people.dart';

part 'people_dto.g.dart';

@JsonSerializable()
class PeopleDto extends Equatable {
  const PeopleDto({
    required this.id,
    required this.name,
    required this.title,
  });

  final int id;
  final String name;
  final String title;

  People toDomain() => People(
        id: id,
        name: name,
        title: title,
      );

  factory PeopleDto.fromJson(Map<String, dynamic> json) => _$PeopleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PeopleDtoToJson(this);

  @override
  List<Object?> get props => [id, name, title];
}
