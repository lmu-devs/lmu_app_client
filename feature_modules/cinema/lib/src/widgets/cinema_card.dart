import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/cinema.dart';
import 'package:flutter/material.dart';

import '../repository/api/api.dart';
import '../routes/cinema_details_data.dart';
import '../util/cinema_type.dart';
import '../util/screening_time.dart';

class CinemaCard extends StatelessWidget {
  const CinemaCard({
    super.key,
    required this.cinema,
    required this.screenings,
  });

  final CinemaModel cinema;
  final List<ScreeningModel> screenings;

  @override
  Widget build(BuildContext context) {
    return LmuCard(
      title: cinema.title,
      tagText: cinema.type.getValue(),
      customTagColor: cinema.type.getBackgroundColor(context),
      customTagTextColor: cinema.type.getTextColor(context),
      subtitle: _getDateForNextMovie(context),
      hasDivider: true,
      onTap: () => CinemaDetailsRoute(CinemaDetailsData(cinema: cinema, screenings: screenings)).go(context),
    );
  }

  String _getDateForNextMovie(BuildContext context) {
    final present = DateTime.now();

    if (screenings.isEmpty) {
      return context.locals.cinema.nextMovieEmpty;
    }

    final upcomingScreenings = screenings.where(
      (screening) => DateTime.parse(screening.entryTime).isAfter(present),
    );

    if (upcomingScreenings.isEmpty) {
      return context.locals.cinema.nextMovieEmpty;
    }

    final nextScreening = upcomingScreenings.reduce((current, next) {
      final currentTime = DateTime.parse(current.entryTime);
      final nextTime = DateTime.parse(next.entryTime);
      return currentTime.isBefore(nextTime) ? current : next;
    });

    return '${context.locals.cinema.nextMovie} ${getScreeningTime(context: context, time: nextScreening.entryTime)}';
  }
}
