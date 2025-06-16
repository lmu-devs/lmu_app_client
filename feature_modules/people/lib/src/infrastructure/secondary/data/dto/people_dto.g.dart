// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeopleDto _$PeopleDtoFromJson(Map<String, dynamic> json) => PeopleDto(
      name: json['name'] as String,
      profileUrl: json['profile_url'] as String,
      basicInfo:
          BasicInfoDto.fromJson(json['basic_info'] as Map<String, dynamic>),
      faculty: json['faculty'] as String,
      roles: (json['roles'] as List<dynamic>)
          .map((e) => RoleDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      courses: json['courses'] as List<dynamic>,
      id: json['id'] as String,
    );

Map<String, dynamic> _$PeopleDtoToJson(PeopleDto instance) => <String, dynamic>{
      'name': instance.name,
      'profile_url': instance.profileUrl,
      'basic_info': instance.basicInfo,
      'faculty': instance.faculty,
      'roles': instance.roles,
      'courses': instance.courses,
      'id': instance.id,
    };

BasicInfoDto _$BasicInfoDtoFromJson(Map<String, dynamic> json) => BasicInfoDto(
      lastName: json['last_name'] as String,
      gender: json['gender'] as String,
      firstName: json['first_name'] as String,
      officeHours: json['office_hours'] as String?,
      nameSuffix: json['name_suffix'] as String?,
      employmentStatus: json['employment_status'] as String?,
      title: json['title'] as String?,
      note: json['note'] as String?,
      academicDegree: json['academic_degree'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$BasicInfoDtoToJson(BasicInfoDto instance) =>
    <String, dynamic>{
      'last_name': instance.lastName,
      'gender': instance.gender,
      'first_name': instance.firstName,
      'office_hours': instance.officeHours,
      'name_suffix': instance.nameSuffix,
      'employment_status': instance.employmentStatus,
      'title': instance.title,
      'note': instance.note,
      'academic_degree': instance.academicDegree,
      'status': instance.status,
    };

RoleDto _$RoleDtoFromJson(Map<String, dynamic> json) => RoleDto(
      institution: json['institution'] as String,
      role: json['role'] as String,
      institutionUrl: json['institution_url'] as String,
    );

Map<String, dynamic> _$RoleDtoToJson(RoleDto instance) => <String, dynamic>{
      'institution': instance.institution,
      'role': instance.role,
      'institution_url': instance.institutionUrl,
    };
