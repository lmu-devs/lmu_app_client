import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';

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
            LmuTileHeadline.base(title: context.locals.cinema.moviesTitle),
            ...List.generate(screenings.length, (index) {
              final screening = screenings[index];
              return ScreeningCard(
                screening: screening,
                isLastItem: index == screenings.length - 1,
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
}
