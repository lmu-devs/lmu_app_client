import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';

import '../repository/api/api.dart';
import '../util/cinema_screenings.dart';
import 'cinema_card.dart';
import 'screenings_list.dart';

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
                screenings: getScreeningsForCinema(screenings, cinema.id),
              );
            }),
            const SizedBox(height: LmuSizes.size_20),
            ScreeningsList(
              cinemas: cinemas,
              screenings: screenings,
              hasFilterRow: true,
            ),
            const SizedBox(height: LmuSizes.size_96),
          ],
        ),
      ),
    );
  }
}
