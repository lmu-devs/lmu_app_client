import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../util/screening_filter_keys.dart';

class ScreeningPlaceholder extends StatelessWidget {
  const ScreeningPlaceholder({
    super.key,
    required this.activeFilter,
  });

  final String? activeFilter;

  @override
  Widget build(BuildContext context) {
    return PlaceholderTile(
      minHeight: 165,
      content: activeFilter != null && activeFilter == ScreeningFilterKeys.watchlist
          ? [
              LmuText.body(
                context.locals.cinema.watchlistEmptyBefore,
                color: context.colors.neutralColors.textColors.mediumColors.base,
              ),
              StarIcon(
                isActive: false,
                disabledColor: context.colors.neutralColors.textColors.weakColors.base,
                size: LmuSizes.size_16,
              ),
              LmuText.body(
                context.locals.cinema.watchlistEmptyAfter,
                color: context.colors.neutralColors.textColors.mediumColors.base,
              ),
            ]
          : [
              LmuText.body(
                context.locals.cinema.nextMovieEmpty,
                color: context.colors.neutralColors.textColors.mediumColors.base,
                textAlign: TextAlign.center,
              ),
            ],
    );
  }
}
