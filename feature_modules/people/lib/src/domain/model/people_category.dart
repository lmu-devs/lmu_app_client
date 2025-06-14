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
}
