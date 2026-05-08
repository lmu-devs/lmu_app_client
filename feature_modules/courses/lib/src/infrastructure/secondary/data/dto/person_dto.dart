import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/model/person_model.dart';

part 'person_dto.g.dart';

@JsonSerializable()
class PersonDto extends Equatable {
  const PersonDto({
    required this.firstName,
    required this.lastName,
    this.title,
  });

  factory PersonDto.fromJson(Map<String, dynamic> json) =>
      _$PersonDtoFromJson(json);

  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'surname')
  final String lastName;
  final String? title;

  /// DTO → Domain
  @JsonKey(includeFromJson: false, includeToJson: false)
  PersonModel toDomain() => PersonModel(
        firstName: firstName,
        lastName: lastName,
        title: title,
      );

  Map<String, dynamic> toJson() => _$PersonDtoToJson(this);

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        title,
      ];
}
