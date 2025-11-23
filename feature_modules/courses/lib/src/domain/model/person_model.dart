import 'package:core_routes/courses.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person_model.g.dart';

@JsonSerializable()
class PersonModel extends Equatable implements RPersonModel {
  const PersonModel({
    required this.firstName,
    required this.lastName,
    this.title,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) => _$PersonModelFromJson(json);

  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'surname')
  final String lastName;
  final String? title;

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    title,
  ];

  Map<String, dynamic> toJson() => _$PersonModelToJson(this);
}
