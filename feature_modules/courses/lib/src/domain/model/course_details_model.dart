import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'person_model.dart';
import 'session_model.dart';

part 'course_details_model.g.dart';

@JsonSerializable()
class CourseDetailsModel extends Equatable {
  const CourseDetailsModel({
    required this.sessions,
    required this.persons,
    required this.additionalInformation,
    required this.lastUpdated,
  });

  factory CourseDetailsModel.fromJson(Map<String, dynamic> json) => _$CourseDetailsModelFromJson(json);

  final List<SessionModel> sessions;
  final List<PersonModel> persons;
  @JsonKey(name: 'addtional_information')
  final String additionalInformation;
  @JsonKey(name: 'last_updated')
  final String lastUpdated;

  @override
  List<Object> get props => [
    sessions,
    persons,
    additionalInformation,
    lastUpdated,
  ];

  Map<String, dynamic> toJson() => _$CourseDetailsModelToJson(this);
}
