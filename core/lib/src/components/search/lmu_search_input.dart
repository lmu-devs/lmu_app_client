import 'package:equatable/equatable.dart';

class LmuSearchInput extends Equatable {
  const LmuSearchInput({
    required this.title,
    this.id,
    this.tags,
  });

  final String title;
  final String? id;
  final List<String>? tags;

  @override
  List<Object?> get props => [title, id, tags];
}
