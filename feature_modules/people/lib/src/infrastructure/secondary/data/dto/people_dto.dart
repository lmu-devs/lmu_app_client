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
    required this.facultyId,
    required this.faculty,
    required this.role,
    required this.email,
    required this.phone,
    required this.website,
    required this.room,
    required this.consultation,
    this.isFavorite = false,
  });

  final int id;
  final String name;
  final String surname;
  final String title;
  final String? academicDegree;
  final int facultyId;
  final String faculty;
  final String role;
  final String email;
  final String phone;
  final String website;
  final String room;
  final String consultation;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool isFavorite;

  People toDomain() => People(
        id: id,
        name: name,
        surname: surname,
        title: title,
        academicDegree: academicDegree,
        facultyId: facultyId,
        faculty: faculty,
        role: role,
        email: email,
        phone: phone,
        website: website,
        room: room,
        consultation: consultation,
        isFavorite: isFavorite,
      );

  /// Create a copy with updated favorite status
  PeopleDto copyWith({
    int? id,
    String? name,
    String? surname,
    String? title,
    String? academicDegree,
    int? facultyId,
    String? faculty,
    String? role,
    String? email,
    String? phone,
    String? website,
    String? room,
    String? consultation,
    bool? isFavorite,
  }) {
    return PeopleDto(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      title: title ?? this.title,
      academicDegree: academicDegree ?? this.academicDegree,
      facultyId: facultyId ?? this.facultyId,
      faculty: faculty ?? this.faculty,
      role: role ?? this.role,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      room: room ?? this.room,
      consultation: consultation ?? this.consultation,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory PeopleDto.fromJson(Map<String, dynamic> json) => _$PeopleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PeopleDtoToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        surname,
        title,
        academicDegree,
        facultyId,
        faculty,
        role,
        email,
        phone,
        website,
        room,
        consultation,
        isFavorite
      ];
}
