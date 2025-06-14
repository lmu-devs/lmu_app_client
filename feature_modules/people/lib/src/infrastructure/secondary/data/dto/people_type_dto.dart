import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'people_type_dto.g.dart';

@JsonSerializable()
class PeopleTypeDto extends Equatable {
  const PeopleTypeDto({
    required this.id,
    required this.name,
    this.description,
    required this.emoji,
    required this.peopleIds,
  });

  final String id;
  final String name;
  final String? description;
  final String emoji;
  @JsonKey(name: 'people_ids')
  final List<String> peopleIds;

  factory PeopleTypeDto.fromJson(Map<String, dynamic> json) => _$PeopleTypeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PeopleTypeDtoToJson(this);

  @override
  List<Object?> get props => [id, name, description, emoji, peopleIds];
}
