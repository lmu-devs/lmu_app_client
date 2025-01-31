import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/cupertino.dart';

import '../repository/api/api.dart';
import '../util/cinema_screenings.dart';
import 'movie_teaser_card.dart';

class MovieTeaserList extends StatelessWidget {
  const MovieTeaserList({
    super.key,
    required this.screenings,
  });

  final List<ScreeningModel> screenings;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LmuTileHeadline.base(
          title: context.locals.cinema.upcomingMoviesTitle,
          trailingInfo: '${screenings.length} ${context.locals.cinema.screeningsTitle}',
        ),
        SizedBox(
          height: 230,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemCount: screenings.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: index == 0
                    ? const EdgeInsets.only(
                        left: LmuSizes.size_16,
                        right: LmuSizes.size_8,
                      )
                    : index == (screenings.length - 1)
                        ? const EdgeInsets.only(right: LmuSizes.size_16)
                        : const EdgeInsets.only(right: LmuSizes.size_8),
                child: MovieTeaserCard(
                  screening: screenings[index],
                  cinemaScreenings: getScreeningsForCinema(
                    screenings,
                    screenings[index].movie.id,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
