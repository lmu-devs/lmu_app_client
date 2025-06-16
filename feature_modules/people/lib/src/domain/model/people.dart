import 'package:equatable/equatable.dart';

class People extends Equatable {
  const People({
    required this.id,
    required this.name,
    required this.profileUrl,
    required this.basicInfo,
    required this.faculty,
    required this.roles,
    required this.courses,
  });

  final String id;
  final String name;
  final String profileUrl;
  final BasicInfo basicInfo;
  final String faculty;
  final List<Role> roles;
  final List<dynamic> courses;

  @override
  List<Object?> get props => [id];
}

class BasicInfo extends Equatable {
  const BasicInfo({
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

  final String lastName;
  final String gender;
  final String firstName;
  final String? officeHours;
  final String? nameSuffix;
  final String? employmentStatus;
  final String? title;
  final String? note;
  final String? academicDegree;
  final String? status;

  @override
  List<Object?> get props =>
      [lastName, gender, firstName, officeHours, nameSuffix, employmentStatus, title, note, academicDegree, status];
}

class Role extends Equatable {
  const Role({
    required this.institution,
    required this.role,
    required this.institutionUrl,
  });

  final String institution;
  final String role;
  final String institutionUrl;

  @override
  List<Object?> get props => [institution, role, institutionUrl];
}
