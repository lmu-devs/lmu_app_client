import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../pages/cinema_details_page.dart';
import '../repository/api/api.dart';
import '../repository/api/models/cinema/cinema.dart';
import '../routes/cinema_details_data.dart';
import '../util/cinema_type.dart';
import '../util/screening_time.dart';

class CinemaCard extends StatelessWidget {
  const CinemaCard({
    Key? key,
    required this.cinema,
    required this.screenings,
    required this.isLastItem,
  }) : super(key: key);

  final CinemaModel cinema;
  final List<ScreeningModel> screenings;
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: isLastItem ? LmuSizes.none : LmuSizes.size_12,
      ),
      padding: const EdgeInsets.all(LmuSizes.size_4),
      decoration: BoxDecoration(
        color: context.colors.neutralColors.backgroundColors.tile,
        borderRadius: const BorderRadius.all(
          Radius.circular(LmuRadiusSizes.mediumLarge),
        ),
      ),
      child: LmuListItem.base(
        title: cinema.title,
        titleInTextVisuals: [LmuInTextVisual.text(title: cinema.type.getValue())],
        subtitle: _getDateForNextMovie(context),
        hasHorizontalPadding: true,
        hasVerticalPadding: true,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CinemaDetailsPage(
              cinemaDetailsData: CinemaDetailsData(
                cinema: cinema,
                screenings: screenings,
              ),
            ),
          ),
        ),
      ),
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

    return '${context.locals.cinema.nextMovie} • ${getScreeningTime(context: context, time: nextScreening.entryTime)}';
  }
}
