import 'package:flutter/material.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import '../repository/api/api.dart';

class ScreeningQuickFactsSection extends StatelessWidget {
  const ScreeningQuickFactsSection({
    super.key,
    required this.screening,
  });

  final ScreeningModel screening;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: LmuSizes.size_4,
      runSpacing: LmuSizes.size_6,
      alignment: WrapAlignment.center,
      children: [
        if (screening.movie.budget != null)
          LmuTextBadge(
            title: '${screening.price.toStringAsFixed(2)} €',
            size: BadgeSize.large,
          ),
        if (screening.isOv != null)
          LmuTextBadge(
            title: screening.isOv! ? context.locals.cinema.ov : context.locals.cinema.germanTranslation,
            size: BadgeSize.large,
          ),
        if (screening.movie.releaseYear != null)
          LmuTextBadge(
            title: DateTime.parse(screening.movie.releaseYear!).year.toString(),
            size: BadgeSize.large,
          ),
        if (screening.movie.ratings.isNotEmpty)
          Wrap(
            spacing: LmuSizes.size_4,
            runSpacing: LmuSizes.size_6,
            children: screening.movie.ratings.map((rating) {
              return LmuTextBadge(
                title: '${_normalizeRatingSource(rating.source)} ${rating.rawRating.toString()}',
                size: BadgeSize.large,
              );
            }).toList(),
          ),
      ],
    );
  }

  String _normalizeRatingSource(String ratingSource) {
    if (ratingSource == 'ROTTEN_TOMATOES') {
      return 'Rotten Tomatoes';
    } else if (ratingSource == 'METACRITIC') {
      return 'Metacritic';
    } else {
      return ratingSource;
    }
  }
}
