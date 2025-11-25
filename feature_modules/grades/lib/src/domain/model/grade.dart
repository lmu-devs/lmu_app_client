import 'package:equatable/equatable.dart';

class Grade extends Equatable {
  const Grade({
    required this.id,
    required this.name,
    required this.ects,
    required this.grade,
    required this.semester,
  });

  final String id;
  final String name;
  final int ects;
  final double grade;
  final GradeSemester semester;

  @override
  List<Object?> get props => [id, name, ects, grade, semester];

  Grade copyWith({
    String? id,
    String? name,
    int? ects,
    double? grade,
    GradeSemester? semester,
  }) {
    return Grade(
      id: id ?? this.id,
      name: name ?? this.name,
      ects: ects ?? this.ects,
      grade: grade ?? this.grade,
      semester: semester ?? this.semester,
    );
  }
}

enum GradeSemester {
  winter2020,
  summer2021,
  winter2021,
  summer2022,
  winter2022,
  summer2023,
  winter2023,
  summer2024,
  winter2024,
  summer2025,
  winter2025,
}
