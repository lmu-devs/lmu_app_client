import 'package:equatable/equatable.dart';

class Course extends Equatable {
  const Course({
    required this.id,
    required this.name,
    required this.facultyId,
    this.description,
    this.credits,
    this.semester,
  });

  final String id;
  final String name;
  final int facultyId;
  final String? description;
  final int? credits;
  final String? semester;

  @override
  List<Object?> get props => [id, name, facultyId, description, credits, semester];
}
