import 'package:core/localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../repository/api/api.dart';
import '../repository/api/enums/link_sort_options.dart';

extension SortOptionExtension on SortOption {
  IconData get icon {
    return switch (this) {
      SortOption.alphabetically => LucideIcons.a_large_small,
      SortOption.rating => LucideIcons.star,
    };
  }

  String title(CanteenLocalizations localizations) {
    return switch (this) {
      SortOption.alphabetically => localizations.alphabetically,
      SortOption.rating => localizations.rating,
    };
  }

  List<LinkModel> sort(List<LinkModel> links) {
    final sortedList = List<LinkModel>.from(links);
    switch (this) {
      case SortOption.alphabetically:
        sortedList.sort((a, b) => a.title.compareTo(b.title));
        break;
      case SortOption.rating:
        sortedList.sort((a, b) {
          final likeComparison = b.rating.likeCount.compareTo(a.rating.likeCount);

          if (likeComparison != 0) {
            return likeComparison;
          }

          return a.title.compareTo(b.title);
        });
        break;
    }
    return sortedList;
  }
}
