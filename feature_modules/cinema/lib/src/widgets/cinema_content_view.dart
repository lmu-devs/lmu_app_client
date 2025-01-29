import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../pages/screenings_history_page.dart';
import '../repository/api/api.dart';
import '../repository/api/models/cinema/cinema.dart';
import 'cinema_card.dart';
import 'cinema_filter_row.dart';
import 'screening_card.dart';

class CinemaContentView extends StatelessWidget {
  CinemaContentView({
    super.key,
    required this.cinemas,
    required this.screenings,
  });

  final List<CinemaModel> cinemas;
  final List<ScreeningModel> screenings;

  final ValueNotifier<String?> _activeCinemaIdNotifier = ValueNotifier<String?>(null);

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
            ValueListenableBuilder<String?>(
              valueListenable: _activeCinemaIdNotifier,
              builder: (context, activeCinemaId, child) {
                final futureScreenings = _getFutureScreenings(activeCinemaId);
                return Column(
                  children: [
                    LmuTileHeadline.action(
                      title: context.locals.cinema.moviesTitle,
                      bottomWidget: CinemaFilterButtonRow(
                        activeCinemaId: _activeCinemaIdNotifier.value,
                        onCinemaSelected: (cinemaId) => _activeCinemaIdNotifier.value = cinemaId,
                      ),
                      actionTitle: context.locals.cinema.historyAction,
                      onActionTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ScreeningsHistoryPage(
                            screenings: _getPastScreenings(),
                          ),
                        ),
                      ),
                    ),
                    futureScreenings.isNotEmpty
                        ? AnimatedSwitcher(
                            duration: const Duration(milliseconds: 350),
                            switchInCurve: Curves.easeInOut,
                            switchOutCurve: Curves.easeInOut,
                            reverseDuration: const Duration(milliseconds: 50),
                            transitionBuilder: (child, animation) {
                              return SlideTransition(
                                position:
                                    Tween<Offset>(begin: const Offset(0, .7), end: Offset.zero).animate(animation),
                                child: FadeTransition(opacity: animation, child: child),
                              );
                            },
                            child: ListView.builder(
                              key: ValueKey(futureScreenings.map((screening) => screening.id).join()),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: futureScreenings.length,
                              itemBuilder: (context, index) {
                                final screening = futureScreenings[index];
                                return ScreeningCard(
                                  screening: screening,
                                  isLastItem: index == futureScreenings.length - 1,
                                );
                              },
                            ),
                          )
                        : PlaceholderTile(
                            minHeight: 165,
                            content: [
                              LmuText.body(
                                context.locals.cinema.nextMovieEmpty,
                                color: context.colors.neutralColors.textColors.mediumColors.base,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                    const SizedBox(height: LmuSizes.size_96),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  List<ScreeningModel> _getScreeningsForCinema(String cinemaId) {
    return screenings.where((screening) => screening.cinema.id == cinemaId).toList();
  }

  List<ScreeningModel> _getFutureScreenings(String? activeCinemaId) {
    DateTime present = DateTime.now();
    final futureScreenings =
        screenings.where((screening) => DateTime.parse(screening.entryTime).isAfter(present)).toList();

    return futureScreenings
        .where(
          (screening) => activeCinemaId == null || screening.cinema.id == activeCinemaId,
        )
        .toList();
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
