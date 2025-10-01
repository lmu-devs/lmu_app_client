import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';

import '../repository/api/api.dart';
import '../routes/screenings_history_data.dart';
import '../util/cinema_screenings.dart';
import '../util/cinema_type.dart';
import '../util/screening_sorting.dart';
import '../widgets/cinema_empty_states.dart';
import '../widgets/screening_card.dart';

class ScreeningsHistoryPage extends StatefulWidget {
  const ScreeningsHistoryPage({
    super.key,
    required this.screeningsHistoryData,
  });

  final ScreeningsHistoryData screeningsHistoryData;

  @override
  State<ScreeningsHistoryPage> createState() => _ScreeningsHistoryPageState();
}

class _ScreeningsHistoryPageState extends State<ScreeningsHistoryPage> {
  late List<CinemaModel> cinemas;
  late List<ScreeningModel> screenings;

  late ValueNotifier<SortOption> _sortOptionNotifier;
  late ValueNotifier<List<ScreeningModel>> _sortedScreeningsNotifier;

  @override
  void initState() {
    super.initState();
    cinemas = widget.screeningsHistoryData.cinemas;
    screenings = widget.screeningsHistoryData.screenings;

    _sortOptionNotifier = ValueNotifier(SortOption.recentFirst);
    _sortedScreeningsNotifier = ValueNotifier(
      _sortOptionNotifier.value.sort(screenings),
    );
  }

  @override
  void dispose() {
    _sortOptionNotifier.dispose();
    _sortedScreeningsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.cinema;
    final cinema = cinemas.first;

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: localizations.pastMoviesTitle,
        leadingAction: LeadingAction.back,
        largeTitleTrailingWidgetAlignment: MainAxisAlignment.start,
        largeTitleTrailingWidget: cinemas.length == 1
            ? LmuInTextVisual.text(
                title: cinema.type.getValue(),
                textColor: cinema.type.getTextColor(context),
                backgroundColor: cinema.type.getBackgroundColor(context),
              )
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: screenings.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: LmuSizes.size_16),
                    LmuSortingButton<SortOption>(
                      sortOptionNotifier: _sortOptionNotifier,
                      options: SortOption.values,
                      titleBuilder: (option, context) => option.title(context.locals.cinema),
                      iconBuilder: (option) => option.icon,
                      onOptionSelected: (sortOption, context) async {
                        _sortOptionNotifier.value = sortOption;
                        _sortedScreeningsNotifier.value = sortOption.sort(screenings);
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(height: LmuSizes.size_16),
                    ValueListenableBuilder<List<ScreeningModel>>(
                      valueListenable: _sortedScreeningsNotifier,
                      builder: (context, sortedScreenings, _) {
                        return AnimatedSwitcher(
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
                            key: ValueKey(sortedScreenings.map((screening) => screening.id).join()),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: sortedScreenings.length,
                            itemBuilder: (context, index) {
                              final screening = sortedScreenings[index];
                              return ScreeningCard(
                                cinema: getCinemaForScreening(cinemas, screening.cinemaId),
                                screening: screening,
                                cinemaScreenings: getScreeningsForCinema(screenings, screening.cinemaId),
                                isLastItem: index == sortedScreenings.length - 1,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: LmuSizes.size_96),
                  ],
                ),
              )
            : const CinemaEmptyState(emptyStateType: CinemaEmptyStateType.pastMovies),
      ),
    );
  }
}
