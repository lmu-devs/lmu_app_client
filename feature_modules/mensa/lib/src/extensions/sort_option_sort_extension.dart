import '../repository/api/models/mensa_model.dart';
import '../repository/api/models/user_preferences/sort_option.dart';

extension SortOptionSortExtension on SortOption {
  List<MensaModel> sort(
    List<MensaModel> mensaModels,
  ) {
    switch (this) {
      case SortOption.alphabetically:
        return List.from(mensaModels)..sort((a, b) => a.name.compareTo(b.name));
      case SortOption.rating:
        return List.from(mensaModels)..sort((a, b) => b.ratingModel.likeCount.compareTo(a.ratingModel.likeCount));
      case SortOption.type:
        return List.from(mensaModels)
          ..sort((a, b) {
            final typeComparison = a.type.index.compareTo(b.type.index);
            if (typeComparison != 0) return typeComparison;
            return a.name.compareTo(b.name);
          });
      default:
        return List.from(mensaModels);
    }
  }
}
