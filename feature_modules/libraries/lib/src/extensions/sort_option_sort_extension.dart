import 'package:core/core_services.dart';
import 'package:get_it/get_it.dart';

import '../repository/api/api.dart';
import '../repository/api/enums/sort_options.dart';

extension SortOptionSortExtension on SortOption {
  List<LibraryModel> sort(List<LibraryModel> libraries) {
    switch (this) {
      case SortOption.alphabetically:
        return List.from(libraries)
          ..sort((a, b) {
            final nameComparison = a.name.compareTo(b.name);
            return nameComparison;
          });
      case SortOption.rating:
        return List.from(libraries)
          ..sort((a, b) {
            final likeCountComparison = b.rating.likeCount.compareTo(a.rating.likeCount);
            if (likeCountComparison != 0) return likeCountComparison;
            final nameComparison = a.name.compareTo(b.name);
            return nameComparison;
          });
      case SortOption.distance:
        final distanceService = GetIt.I.get<LocationService>();
        return List.from(libraries)
          ..sort((a, b) {
            final distanceA = distanceService.getDistance(lat: a.location.latitude, long: a.location.longitude);
            final distanceB = distanceService.getDistance(lat: b.location.latitude, long: b.location.longitude);
            if (distanceA == null && distanceB == null) return 0;
            if (distanceA == null) return 1;
            if (distanceB == null) return -1;
            final distanceComparison = distanceA.compareTo(distanceB);
            if (distanceComparison != 0) return distanceComparison;
            final nameComparison = a.name.compareTo(b.name);
            return nameComparison;
          });
    }
  }
}
