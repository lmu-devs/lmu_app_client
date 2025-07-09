import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/model/people.dart';

part 'people_dto.g.dart';

@JsonSerializable()
class PeopleDto extends Equatable {
  const PeopleDto({
    required this.id,
    required this.name,
    required this.surname,
    required this.title,
    this.academicDegree,
    required this.faculty,
    required this.role,
    required this.email,
    required this.phone,
    required this.website,
    required this.room,
    required this.consultation,
  });

  final int id;
  final String name;
  final String surname;
  final String title;
  final String? academicDegree;
  final String faculty;
  final String role;
  final String email;
  final String phone;
  final String website;
  final String room;
  final String consultation;

  People toDomain() => People(
        id: id,
        name: name,
        surname: surname,
        title: title,
        academicDegree: academicDegree,
        faculty: faculty,
        role: role,
        email: email,
        phone: phone,
        website: website,
        room: room,
        consultation: consultation,
      );

  factory PeopleDto.fromJson(Map<String, dynamic> json) => _$PeopleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PeopleDtoToJson(this);

  @override
  List<Object?> get props =>
      [id, name, surname, title, academicDegree, faculty, role, email, phone, website, room, consultation];
}
