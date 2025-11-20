import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/model/course_details_model.dart';
import 'session_dto.dart';
import 'person_dto.dart';

part 'course_details_dto.g.dart';

@JsonSerializable()
class CourseDetailsDto extends Equatable {
  const CourseDetailsDto({
    required this.sessions,
    required this.persons,
    required this.additionalInformation,
    required this.lastUpdated,
  });

  factory CourseDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$CourseDetailsDtoFromJson(json);

  final List<SessionDto> sessions;
  final List<PersonDto> persons;
  @JsonKey(name: 'addtional_information')
  final String additionalInformation;
  @JsonKey(name: 'last_updated')
  final String lastUpdated;

  /// Convert DTO → Domain Model
  @JsonKey(includeFromJson: false, includeToJson: false)
  CourseDetailsModel toDomain() => CourseDetailsModel(
    sessions: sessions.map((session) => session.toDomain()).toList(),
    persons: persons.map((person) => person.toDomain()).toList(),
    additionalInformation: additionalInformation,
    lastUpdated: lastUpdated,
  );

  Map<String, dynamic> toJson() => _$CourseDetailsDtoToJson(this);

  @override
  List<Object?> get props => [
    sessions,
    persons,
    additionalInformation,
    lastUpdated,
  ];
}
