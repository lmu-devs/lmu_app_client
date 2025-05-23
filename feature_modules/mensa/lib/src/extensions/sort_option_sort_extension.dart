import 'package:core/core_services.dart';
import 'package:get_it/get_it.dart';

import '../repository/api/models/mensa/mensa_model.dart';
import '../repository/api/models/user_preferences/sort_option.dart';

extension SortOptionSortExtension on SortOption {
  List<MensaModel> sort(List<MensaModel> mensaModels) {
    switch (this) {
      case SortOption.alphabetically:
        return List.from(mensaModels)
          ..sort((a, b) {
            final nameComparison = a.name.compareTo(b.name);
            if (nameComparison != 0) return nameComparison;

            return a.type.index.compareTo(b.type.index);
          });
      case SortOption.rating:
        return List.from(mensaModels)
          ..sort((a, b) {
            final likeCountComparison = b.ratingModel.likeCount.compareTo(a.ratingModel.likeCount);
            if (likeCountComparison != 0) return likeCountComparison;
            final nameComparison = a.name.compareTo(b.name);
            if (nameComparison != 0) return nameComparison;
            return a.type.index.compareTo(b.type.index);
          });
      case SortOption.type:
        return List.from(mensaModels)
          ..sort((a, b) {
            final typeComparison = a.type.index.compareTo(b.type.index);
            if (typeComparison != 0) return typeComparison;
            return a.name.compareTo(b.name);
          });
      case SortOption.distance:
        final distanceService = GetIt.I.get<LocationService>();
        return List.from(mensaModels)
          ..sort((a, b) {
            final distanceA = distanceService.getDistance(lat: a.location.latitude, long: a.location.longitude);
            final distanceB = distanceService.getDistance(lat: b.location.latitude, long: b.location.longitude);
            if (distanceA == null && distanceB == null) return 0;
            if (distanceA == null) return 1;
            if (distanceB == null) return -1;
            final distanceComparison = distanceA.compareTo(distanceB);
            if (distanceComparison != 0) return distanceComparison;
            final nameComparison = a.name.compareTo(b.name);
            if (nameComparison != 0) return nameComparison;
            return a.type.index.compareTo(b.type.index);
          });
    }
  }
}
