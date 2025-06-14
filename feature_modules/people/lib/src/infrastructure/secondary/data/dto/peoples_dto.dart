import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'people_dto.dart';
import 'people_type_dto.dart';

part 'peoples_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class PeoplesDto extends Equatable {
  const PeoplesDto({
    required this.peopleTypes,
    required this.peoples,
  });

  @JsonKey(name: 'people_types')
  final List<PeopleTypeDto> peopleTypes;
  final List<PeopleDto> peoples;

  factory PeoplesDto.fromJson(Map<String, dynamic> json) => _$PeoplesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PeoplesDtoToJson(this);

  @override
  List<Object?> get props => [peopleTypes, peoples];
}
