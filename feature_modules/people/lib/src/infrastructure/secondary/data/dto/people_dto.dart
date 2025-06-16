import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'people_dto.g.dart';

// data transfer object (DTO) für datentransferierung
@JsonSerializable()
class PeopleDto extends Equatable {
  const PeopleDto({
    required this.name,
    required this.profileUrl,
    required this.basicInfo,
    required this.faculty,
    required this.roles,
    required this.courses,
    required this.id,
  });

  final String name;
  @JsonKey(name: 'profile_url')
  final String profileUrl;
  @JsonKey(name: 'basic_info')
  final BasicInfoDto basicInfo;
  final String faculty;
  final List<RoleDto> roles;
  final List<dynamic> courses;
  final String id;

  factory PeopleDto.fromJson(Map<String, dynamic> json) {
    // Handle null values by providing default empty strings for required fields
    return PeopleDto(
      name: json['name'] as String? ?? '',
      profileUrl: json['profile_url'] as String? ?? '',
      basicInfo: BasicInfoDto.fromJson(json['basic_info'] as Map<String, dynamic>? ?? {}),
      faculty: json['faculty'] as String? ?? '',
      roles: (json['roles'] as List<dynamic>? ?? []).map((e) => RoleDto.fromJson(e as Map<String, dynamic>)).toList(),
      courses: json['courses'] as List<dynamic>? ?? [],
      id: json['id'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => _$PeopleDtoToJson(this);

  @override
  List<Object?> get props => [name, profileUrl, basicInfo, faculty, roles, courses, id];
}

@JsonSerializable()
class BasicInfoDto extends Equatable {
  const BasicInfoDto({
    required this.lastName,
    required this.gender,
    required this.firstName,
    this.officeHours,
    this.nameSuffix,
    this.employmentStatus,
    this.title,
    this.note,
    this.academicDegree,
    this.status,
  });

  @JsonKey(name: 'last_name')
  final String lastName;
  final String gender;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'office_hours')
  final String? officeHours;
  @JsonKey(name: 'name_suffix')
  final String? nameSuffix;
  @JsonKey(name: 'employment_status')
  final String? employmentStatus;
  final String? title;
  final String? note;
  @JsonKey(name: 'academic_degree')
  final String? academicDegree;
  final String? status;

  factory BasicInfoDto.fromJson(Map<String, dynamic> json) {
    // Handle null values by providing default empty strings for required fields
    return BasicInfoDto(
      lastName: json['last_name'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      firstName: json['first_name'] as String? ?? '',
      officeHours: json['office_hours'] as String?,
      nameSuffix: json['name_suffix'] as String?,
      employmentStatus: json['employment_status'] as String?,
      title: json['title'] as String?,
      note: json['note'] as String?,
      academicDegree: json['academic_degree'] as String?,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() => _$BasicInfoDtoToJson(this);

  @override
  List<Object?> get props =>
      [lastName, gender, firstName, officeHours, nameSuffix, employmentStatus, title, note, academicDegree, status];
}

@JsonSerializable()
class RoleDto extends Equatable {
  const RoleDto({
    required this.institution,
    required this.role,
    required this.institutionUrl,
  });

  final String institution;
  final String role;
  @JsonKey(name: 'institution_url')
  final String institutionUrl;

  factory RoleDto.fromJson(Map<String, dynamic> json) {
    // Handle null values by providing default empty strings for required fields
    return RoleDto(
      institution: json['institution'] as String? ?? '',
      role: json['role'] as String? ?? '',
      institutionUrl: json['institution_url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => _$RoleDtoToJson(this);

  @override
  List<Object?> get props => [institution, role, institutionUrl];
}
