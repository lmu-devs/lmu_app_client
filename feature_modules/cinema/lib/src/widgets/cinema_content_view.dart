import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../repository/api/api.dart';
import '../repository/api/models/screening_model.dart';

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
              return Container(
                margin: EdgeInsets.only(
                  bottom: index == cinemas.length - 1 ? LmuSizes.none : LmuSizes.size_12,
                ),
                decoration: BoxDecoration(
                  color: context.colors.neutralColors.backgroundColors.tile,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(LmuRadiusSizes.mediumLarge),
                  ),
                ),
                child: LmuListItem.base(
                  title: cinema.title,
                  titleInTextVisuals: [LmuInTextVisual.text(title: cinema.id)],
                  subtitle: 'Nächster Film • Morgen',
                  hasHorizontalPadding: true,
                  hasVerticalPadding: true,
                  onTap: () => print(cinema.id),
                ),
              );
            }),
            const SizedBox(height: LmuSizes.size_32),
            LmuTileHeadline.base(title: context.locals.cinema.moviesTitle),
            ...List.generate(screenings.length, (index) {
              final screening = screenings[index];
              return GestureDetector(
                onTap: () => print(screening.movie.title),
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: index == screenings.length - 1 ? LmuSizes.none : LmuSizes.size_12,
                  ),
                  decoration: BoxDecoration(
                    color: context.colors.neutralColors.backgroundColors.tile,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(LmuRadiusSizes.mediumLarge),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      screening.movie.poster != null
                          ? ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(LmuRadiusSizes.mediumLarge),
                                bottomLeft: Radius.circular(LmuRadiusSizes.mediumLarge),
                              ),
                              child: FutureBuilder(
                                future: precacheImage(NetworkImage(screening.movie.poster!.url), context),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done) {
                                    return Image.network(
                                      screening.movie.poster!.url,
                                      height: 165,
                                      width: 116,
                                      fit: BoxFit.cover,
                                      semanticLabel: screening.movie.poster!.name,
                                    );
                                  } else {
                                    return LmuSkeleton(
                                      child: Container(
                                        height: 165,
                                        width: 116,
                                        color: Colors.white,
                                      ),
                                    );
                                  }
                                },
                              ),
                            )
                          : Center(child: Text(screening.movie.title)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(LmuSizes.size_16),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: LmuText.body(
                                      screening.movie.title,
                                      maxLines: null,
                                      customOverFlow: TextOverflow.visible,
                                    ),
                                  ),
                                  const SizedBox(height: LmuSizes.size_4),
                                  LmuText.bodySmall(
                                    screening.entryTime,
                                    color: context.colors.neutralColors.textColors.mediumColors.base,
                                  ),
                                  const SizedBox(height: LmuSizes.size_4),
                                  LmuText.bodySmall(
                                    'Sparche',
                                    color: context.colors.neutralColors.textColors.mediumColors.base,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  LmuInTextVisual.text(title: screening.cinema.id),
                                  const SizedBox(width: LmuSizes.size_2),
                                  //LmuInTextVisual.text(title: ''), // screening.movie.budget.toString()
                                  const SizedBox(width: LmuSizes.size_2),
                                  //LmuInTextVisual.text(title: ''), // screening.movie.ratings.first.normalizedRating.toString()
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: LmuSizes.size_96),
          ],
        ),
      ),
    );
  }
}
