import 'package:core/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../cubit/cinema_cubit/cinema_cubit.dart';
import '../cubit/cinema_cubit/cinema_state.dart';
import '../repository/api/api.dart';
import '../util/cinema_screenings.dart';
import 'movie_teaser_card.dart';
import 'movie_teaser_card_loading.dart';
import 'screening_placeholder.dart';

class MovieTeaserList extends StatelessWidget {
  const MovieTeaserList({
    super.key,
    this.screenings,
    this.headlineActionText,
    this.headlineActionFunction,
  });

  final List<ScreeningModel>? screenings;
  final String? headlineActionText;
  final VoidCallback? headlineActionFunction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        screenings != null
            ? _TeaserList(screenings: screenings!)
            : BlocBuilder<CinemaCubit, CinemaState>(
                bloc: GetIt.I.get<CinemaCubit>(),
                builder: (context, state) {
                  if (state is CinemaLoadSuccess) {
                    final upcomingScreenings = state.screenings
                        .where((screening) {
                          DateTime entryTime = DateTime.parse(screening.entryTime);
                          DateTime expiryTime = DateTime(entryTime.year, entryTime.month, entryTime.day + 1, 0, 0);
                          return expiryTime.isAfter(DateTime.now());
                        })
                        .take(6)
                        .toList();

                    return _TeaserList(screenings: upcomingScreenings);
                  }
                  return const _TeaserLoading();
                },
              ),
        const SizedBox(height: LmuSizes.size_24),
      ],
    );
  }
}

class _TeaserList extends StatelessWidget {
  const _TeaserList({required this.screenings});

  final List<ScreeningModel> screenings;

  @override
  Widget build(BuildContext context) {
    return screenings.isNotEmpty
        ? SizedBox(
            height: 230,
            width: double.infinity,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: screenings.length,
              itemBuilder: (context, index) => Padding(
                padding: _TeaserListPadding.getPadding(index, screenings.length),
                child: MovieTeaserCard(
                  screening: screenings[index],
                  cinemaScreenings: getScreeningsForCinema(
                    screenings,
                    screenings[index].cinema.id,
                  ),
                ),
              ),
            ),
          )
        : const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: LmuSizes.size_16,
            ),
            child: ScreeningPlaceholder(minHeight: 165),
          );
  }
}

class _TeaserLoading extends StatelessWidget {
  const _TeaserLoading();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: 6,
        itemBuilder: (context, index) => Padding(
          padding: _TeaserListPadding.getPadding(index, 5),
          child: const MovieTeaserCardLoading(),
        ),
      ),
    );
  }
}

class _TeaserListPadding {
  static EdgeInsets getPadding(int index, int totalItems) {
    if (index == 0) {
      return const EdgeInsets.only(left: LmuSizes.size_16, right: LmuSizes.size_8);
    } else if (index == totalItems - 1) {
      return const EdgeInsets.only(right: LmuSizes.size_16);
    }
    return const EdgeInsets.only(right: LmuSizes.size_8);
  }
}
