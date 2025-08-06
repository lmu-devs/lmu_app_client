import 'package:equatable/equatable.dart';

class Lecture extends Equatable {
  const Lecture({
    required this.id,
    required this.title,
    required this.tags,
    required this.facultyId,
    this.description,
    this.credits,
    this.semester,
  });

  final String id;
  final String title;
  final List<String> tags;
  final int facultyId;
  final String? description;
  final int? credits;
  final String? semester;

  Lecture copyWith({
    String? id,
    String? title,
    List<String>? tags,
    int? facultyId,
    String? description,
    int? credits,
    String? semester,
  }) {
    return Lecture(
      id: id ?? this.id,
      title: title ?? this.title,
      tags: tags ?? this.tags,
      facultyId: facultyId ?? this.facultyId,
      description: description ?? this.description,
      credits: credits ?? this.credits,
      semester: semester ?? this.semester,
    );
  }

  @override
  List<Object?> get props => [id, title, tags, facultyId, description, credits, semester];
}
