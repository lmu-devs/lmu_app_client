import 'club.dart';
import 'club_category_type.dart';

class ClubCategory {
  const ClubCategory({
    required this.type,
    required this.clubs,
  });

  final ClubCategoryType type;
  final List<Club> clubs;
}
