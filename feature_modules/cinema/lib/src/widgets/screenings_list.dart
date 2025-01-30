import '../util/cinema_screenings.dart';
import '../util/cinema_type.dart';
import 'screening_card.dart';
import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../pages/screenings_history_page.dart';
import '../repository/api/api.dart';
import 'cinema_filter_row.dart';

class ScreeningsList extends StatelessWidget {
  ScreeningsList({
    super.key,
    required this.screenings,
    required this.hasFilterRow,
    this.type,
  });

  final List<ScreeningModel> screenings;
  final bool hasFilterRow;
  final CinemaType? type;

  final ValueNotifier<String?> _activeCinemaIdNotifier = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: _activeCinemaIdNotifier,
      builder: (context, activeCinemaId, child) {
        final futureScreenings = _getFutureScreenings(activeCinemaId);
        return Column(
          children: [
            LmuTileHeadline.action(
              title: context.locals.cinema.upcomingTitle,
              bottomWidget: hasFilterRow
                  ? CinemaFilterButtonRow(
                      activeCinemaId: _activeCinemaIdNotifier.value,
                      onCinemaSelected: (cinemaId) => _activeCinemaIdNotifier.value = cinemaId,
                    )
                  : null,
              actionTitle: context.locals.cinema.historyAction,
              onActionTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ScreeningsHistoryPage(
                    screenings: _getPastScreenings(),
                    type: type,
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
                        position: Tween<Offset>(begin: const Offset(0, .7), end: Offset.zero).animate(animation),
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
                          cinemaScreenings: getScreeningsForCinema(screenings, screening.cinema.id),
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
          ],
        );
      },
    );
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
