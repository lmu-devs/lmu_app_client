import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/cinema.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../repository/api/api.dart';
import '../routes/screenings_history_data.dart';
import '../services/cinema_user_preference_service.dart';
import '../util/cinema_screenings.dart';
import '../util/cinema_type.dart';
import '../util/screening_filter_keys.dart';
import 'cinema_filter_row.dart';
import 'screening_card.dart';
import 'screening_placeholder.dart';

class ScreeningsList extends StatelessWidget {
  ScreeningsList({
    super.key,
    required this.cinemas,
    required this.screenings,
    required this.hasFilterRow,
    this.type,
  });

  final List<CinemaModel> cinemas;
  final List<ScreeningModel> screenings;
  final bool hasFilterRow;
  final CinemaType? type;

  final ValueNotifier<String?> _activeFilterNotifier = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: _activeFilterNotifier,
      builder: (context, activeFilter, child) {
        final futureScreenings = _getFutureScreenings(activeFilter);
        return Column(
          children: [
            LmuTileHeadline.action(
              title: context.locals.cinema.upcomingTitle,
              bottomWidget: hasFilterRow
                  ? CinemaFilterButtonRow(
                      activeFilter: _activeFilterNotifier.value,
                      onFilterSelected: (filter) => _activeFilterNotifier.value = filter,
                    )
                  : null,
              actionTitle: context.locals.cinema.historyAction,
              onActionTap: () => ScreeningsHistoryRoute(
                ScreeningsHistoryData(cinemas: cinemas, screenings: _getPastScreenings()),
              ).go(context),
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
                          key: ValueKey(screening.id),
                          cinema: getCinemaForScreening(cinemas, screening.cinemaId),
                          screening: screening,
                          cinemaScreenings: getScreeningsForCinema(screenings, screening.cinemaId),
                          isLastItem: index == futureScreenings.length - 1,
                        );
                      },
                    ),
                  )
                : ScreeningPlaceholder(activeFilter: _activeFilterNotifier.value),
          ],
        );
      },
    );
  }

  List<ScreeningModel> _getFutureScreenings(String? activeFilter) {
    DateTime present = DateTime.now();

    final futureScreenings = screenings.where((screening) {
      DateTime entryTime = DateTime.parse(screening.entryTime);
      DateTime expiryTime = DateTime(entryTime.year, entryTime.month, entryTime.day + 1, 0, 0);

      return expiryTime.isAfter(present);
    }).toList();

    if (activeFilter == ScreeningFilterKeys.watchlist) {
      final likedScreeningIds = GetIt.I<CinemaUserPreferenceService>().likedScreeningsIdsNotifier.value;
      return futureScreenings.where((screening) => likedScreeningIds.contains(screening.id)).toList();
    } else if (activeFilter == ScreeningFilterKeys.munich) {
      return futureScreenings.where((screening) => screening.cinemaId != 'TUM_GARCHING').toList();
    } else if (activeFilter == ScreeningFilterKeys.garching) {
      return futureScreenings.where((screening) => screening.cinemaId == 'TUM_GARCHING').toList();
    }

    return futureScreenings;
  }

  List<ScreeningModel> _getPastScreenings() {
    DateTime present = DateTime.now();

    return screenings
        .where((screening) {
          DateTime entryTime = DateTime.parse(screening.entryTime);
          DateTime expiryTime = DateTime(entryTime.year, entryTime.month, entryTime.day + 1, 0, 0);

          return expiryTime.isBefore(present);
        })
        .toList()
        .reversed
        .toList();
  }
}
