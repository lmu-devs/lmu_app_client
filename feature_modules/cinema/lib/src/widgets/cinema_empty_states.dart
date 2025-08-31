import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/widgets.dart';

enum CinemaEmptyStateType {
  pastMovies, screenings,
}

extension CinemaEmptyStateTypeX on CinemaEmptyStateType {
  String assetName() {
    return switch (this) {
      CinemaEmptyStateType.pastMovies => "lib/assets/no_movies.webp",
      CinemaEmptyStateType.screenings => "lib/assets/no_screenings.webp",
    };
  }

  String localizedTitle(BuildContext context) {
    return switch (this) {
      CinemaEmptyStateType.pastMovies => context.locals.cinema.pastMoviesEmpty,
      CinemaEmptyStateType.screenings => context.locals.cinema.nextMovieEmpty,
    };
  }

  String localizedDescription(BuildContext context) {
    return switch (this) {
      CinemaEmptyStateType.pastMovies => context.locals.cinema.pastMoviesEmptyStateDescription,
      CinemaEmptyStateType.screenings => context.locals.cinema.screeningsEmptyStateDescription,
    };
  }
}

class CinemaEmptyState extends StatelessWidget {
  const CinemaEmptyState({super.key, required this.emptyStateType});
  
  final CinemaEmptyStateType emptyStateType;

  @override
  Widget build(BuildContext context) {
    return LmuEmptyState(
      type: EmptyStateType.custom,
      hasVerticalPadding: true,
      assetName: emptyStateType.assetName(),
      title: emptyStateType.localizedTitle(context),
      description: emptyStateType.localizedDescription(context),
    );
  }
}
