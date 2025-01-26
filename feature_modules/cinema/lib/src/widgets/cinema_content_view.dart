import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';

import '../pages/screenings_history_page.dart';
import '../repository/api/api.dart';
import '../repository/api/models/screening_model.dart';
import 'cinema_card.dart';
import 'screening_card.dart';

class CinemaContentView extends StatelessWidget {
  const CinemaContentView({
    super.key,
    required this.cinemas,
    required this.screenings,
  });

  final List<CinemaModel> cinemas;
  final List<ScreeningModel> screenings;

  @override
  Widget build(BuildContext context) {
    final futureScreenings = _getFutureScreenings();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: LmuSizes.size_16),
            LmuTileHeadline.base(title: context.locals.cinema.cinemasTitle),
            ...List.generate(cinemas.length, (index) {
              final cinema = cinemas[index];
              return CinemaCard(
                cinema: cinema,
                screenings: _getScreeningsForCinema(cinema.id),
                isLastItem: index == cinemas.length - 1,
              );
            }),
            const SizedBox(height: LmuSizes.size_32),
            LmuTileHeadline.action(
              title: context.locals.cinema.moviesTitle,
              actionTitle: context.locals.cinema.historyAction,
              onActionTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ScreeningsHistoryPage(
                    screenings: _getPastScreenings(),
                  ),
                ),
              ),
            ),
            ...List.generate(futureScreenings.length, (index) {
              final screening = futureScreenings[index];
              return ScreeningCard(
                screening: screening,
                isLastItem: index == futureScreenings.length - 1,
              );
            }),
            const SizedBox(height: LmuSizes.size_96),
          ],
        ),
      ),
    );
  }

  List<ScreeningModel> _getScreeningsForCinema(String cinemaId) {
    return screenings.where((screening) => screening.cinema.id == cinemaId).toList();
  }

  List<ScreeningModel> _getFutureScreenings() {
    DateTime present = DateTime.now();
    return screenings.where((screening) => DateTime.parse(screening.entryTime).isAfter(present)).toList();
  }

  List<ScreeningModel> _getPastScreenings() {
    DateTime present = DateTime.now();
    return screenings
        .where((screening) => DateTime.parse(screening.entryTime).isBefore(present))
        .toList()
        .reversed
        .toList();
  }
}
