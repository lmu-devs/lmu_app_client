import 'package:equatable/equatable.dart';

class Lecture extends Equatable {
  const Lecture({
    required this.id,
    required this.title,
    required this.tags,
    this.isFavorite = false,
  });

  final String id;
  final String title;
  final List<String> tags;
  final bool isFavorite;

  Lecture copyWith({
    String? id,
    String? title,
    List<String>? tags,
    bool? isFavorite,
  }) {
    return Lecture(
      id: id ?? this.id,
      title: title ?? this.title,
      tags: tags ?? this.tags,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [id, title, tags, isFavorite];
}
