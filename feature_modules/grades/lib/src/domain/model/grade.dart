import 'package:equatable/equatable.dart';

import 'grade_semester.dart';

class Grade extends Equatable {
  const Grade({
    required this.id,
    required this.name,
    required this.ects,
    required this.grade,
    required this.semester,
    this.isActive = true,
  });

  final String id;
  final String name;
  final int ects;
  final double? grade;
  final GradeSemester semester;
  final bool isActive;

  @override
  List<Object?> get props => [id, name, ects, grade, semester, isActive];

  Grade copyWith({
    String? id,
    String? name,
    int? ects,
    double? grade,
    GradeSemester? semester,
    bool? isActive,
  }) {
    return Grade(
      id: id ?? this.id,
      name: name ?? this.name,
      ects: ects ?? this.ects,
      grade: grade ?? this.grade,
      semester: semester ?? this.semester,
      isActive: isActive ?? this.isActive,
    );
  }
}
