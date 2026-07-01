import 'club.dart';

class ClubCategory {
  const ClubCategory({
    required this.id,
    required this.title,
    required this.emoji,
    required this.clubs,
    this.description,
  });

  final String id;
  final String title;
  final String? description;
  final String emoji;
  final List<Club> clubs;
}
