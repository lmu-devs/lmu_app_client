import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../repository/api/api.dart';

enum SortOption {
  alphabetically,
  recentFirst,
  recentLast,
}

extension SortOptionExtension on SortOption {
  IconData get icon {
    switch (this) {
      case SortOption.alphabetically:
        return LucideIcons.a_large_small;
      case SortOption.recentFirst:
        return LucideIcons.arrow_down;
      case SortOption.recentLast:
        return LucideIcons.arrow_up;
    }
  }

  String title(CinemaLocalizations localizations) {
    switch (this) {
      case SortOption.alphabetically:
        return localizations.screeningsSortingAlphabetical;
      case SortOption.recentFirst:
        return localizations.screeningsSortingMostRecent;
      case SortOption.recentLast:
        return localizations.screeningsSortingLeastRecent;
    }
  }

  List<ScreeningModel> sort(List<ScreeningModel> screenings) {
    switch (this) {
      case SortOption.alphabetically:
        return List.from(screenings)
          ..sort((a, b) => a.movie.title.compareTo(b.movie.title));
      case SortOption.recentFirst:
        return List.from(screenings)
          ..sort((a, b) => DateTime.parse(a.entryTime).isAfter(DateTime.parse(b.entryTime)) ? -1 : 1);
      case SortOption.recentLast:
        return List.from(screenings)
          ..sort((a, b) => DateTime.parse(b.entryTime).isAfter(DateTime.parse(a.entryTime)) ? -1 : 1);
    }
  }
}
