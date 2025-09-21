import 'package:equatable/equatable.dart';

class Lecture extends Equatable {
  const Lecture({
    required this.id,
    required this.title,
    this.description,
    this.sws,
    this.semester,
    this.tags = const [],
    this.facultyId,
  });

  final String id;
  final String title;
  final String? description;
  final int? sws;
  final String? semester;
  final List<String> tags;
  final int? facultyId;

  @override
  List<Object?> get props => [id, title, description, sws, semester, tags, facultyId];
}
