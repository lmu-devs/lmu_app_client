import 'animal.dart';
import 'rarity.dart';

class LmuDeveloper {
  const LmuDeveloper({
    required this.id,
    required this.name,
    required this.animal,
    this.rarity = Rarity.common,
    this.tags = const [],
    this.description,
  });

  final String id;
  final String name;
  final Animal animal;
  final Rarity rarity;
  final List<String> tags;
  final String? description;
}
