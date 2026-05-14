import 'package:equatable/equatable.dart';

import 'grade_semester.dart';

const _sentinel = Object();

class Grade extends Equatable {
  const Grade({
    required this.id,
    required this.name,
    required this.ects,
    required this.grade,
    required this.semester,
    this.isActive = true,
    this.courseId,
  });

  final String id;
  final String name;
  final double ects;
  final double? grade;
  final GradeSemester semester;
  final bool isActive;
  final int? courseId;

  @override
  List<Object?> get props => [id, name, ects, grade, semester, isActive, courseId];

  Grade copyWith({
    String? id,
    String? name,
    double? ects,
    Object? grade = _sentinel,
    GradeSemester? semester,
    bool? isActive,
    Object? courseId = _sentinel,
  }) {
    return Grade(
      id: id ?? this.id,
      name: name ?? this.name,
      ects: ects ?? this.ects,
      grade: grade == _sentinel ? this.grade : grade as double?,
      semester: semester ?? this.semester,
      isActive: isActive ?? this.isActive,
      courseId: courseId == _sentinel ? this.courseId : courseId as int?,
    );
  }
}
