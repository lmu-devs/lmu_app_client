import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class WatchlistPlaceholder extends StatelessWidget {
  const WatchlistPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PlaceholderTile(
      minHeight: 165,
      content: [
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
      ],
    );
  }
}
