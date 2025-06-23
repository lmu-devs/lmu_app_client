import 'people.dart';

class PeopleCategory {
  const PeopleCategory({
    required this.name,
    required this.emoji,
    required this.peoples,
    this.description,
  });

  final String name;
  final String? description;
  final String emoji;
  final List<People> peoples;

  // Hinzufügen der copyWith-Methode
  PeopleCategory copyWith({
    String? name,
    String? description,
    String? emoji,
    List<People>? peoples,
  }) {
    return PeopleCategory(
      name: name ?? this.name,
      description: description ?? this.description,
      emoji: emoji ?? this.emoji,
      peoples: peoples ?? this.peoples,
    );
  }
}
