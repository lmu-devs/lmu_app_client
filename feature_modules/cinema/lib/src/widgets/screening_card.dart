import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core_routes/cinema.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../repository/api/api.dart';
import '../routes/screening_details_data.dart';
import '../services/cinema_user_preference_service.dart';
import '../util/cinema_type.dart';
import '../util/screening_time.dart';

class ScreeningCard extends StatelessWidget {
  const ScreeningCard({
    Key? key,
    required this.cinema,
    required this.screening,
    required this.cinemaScreenings,
    required this.isLastItem,
  }) : super(key: key);

  final CinemaModel cinema;
  final ScreeningModel screening;
  final List<ScreeningModel> cinemaScreenings;
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    final double cardHeight = 165 * MediaQuery.of(context).textScaler.textScaleFactor;

    return GestureDetector(
      onTap: () => ScreeningDetailsRoute(
        ScreeningDetailsData(cinema: cinema, screening: screening, cinemaScreenings: cinemaScreenings),
      ).push(context),
      child: Container(
        height: cardHeight,
        margin: EdgeInsets.only(
          bottom: isLastItem ? LmuSizes.none : LmuSizes.size_12,
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
                ? Semantics(
                    label: screening.movie.poster!.name,
                    child: Container(
                      height: cardHeight,
                      width: 116,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(LmuRadiusSizes.mediumLarge),
                          bottomLeft: Radius.circular(LmuRadiusSizes.mediumLarge),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: LmuCachedNetworkImageProvider(
                            screening.movie.poster!.url,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: cardHeight,
                    width: 116,
                    decoration: BoxDecoration(
                      color: context.colors.neutralColors.backgroundColors.mediumColors.base,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(LmuRadiusSizes.mediumLarge),
                        bottomLeft: Radius.circular(LmuRadiusSizes.mediumLarge),
                      ),
                      border: Border(
                        top: BorderSide(color: context.colors.neutralColors.backgroundColors.tile, width: 1),
                        bottom: BorderSide(color: context.colors.neutralColors.backgroundColors.tile, width: 1),
                        left: BorderSide(color: context.colors.neutralColors.backgroundColors.tile, width: 1),
                      ),
                    ),
                    child: Center(
                      child: LmuText.caption(
                        screening.movie.title,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: LmuSizes.size_16,
                  right: LmuSizes.size_8,
                  top: LmuSizes.size_8,
                  bottom: LmuSizes.size_16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ValueListenableBuilder<List<String>>(
                          valueListenable: GetIt.I<CinemaUserPreferenceService>().likedScreeningsIdsNotifier,
                          builder: (context, likedScreeningIds, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: LmuText.body(
                                    screening.movie.title,
                                    maxLines: 2,
                                    customOverFlow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: LmuSizes.size_8),
                                GestureDetector(
                                  onTap: () async {
                                    await GetIt.I<CinemaUserPreferenceService>().toggleLikedScreeningId(screening.id);
                                    LmuVibrations.secondary();
                                  },
                                  behavior: HitTestBehavior.translucent,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: LmuSizes.size_8,
                                      right: LmuSizes.size_8,
                                      top: LmuSizes.size_8,
                                      bottom: LmuSizes.size_4,
                                    ),
                                    child: StarIcon(isActive: likedScreeningIds.contains(screening.id)),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        LmuText.bodySmall(
                          getScreeningTime(context: context, time: screening.entryTime),
                          color: context.colors.neutralColors.textColors.mediumColors.base,
                        ),
                        const SizedBox(height: LmuSizes.size_4),
                        LmuText.bodySmall(
                          screening.isOv == true
                              ? context.locals.cinema.ov
                              : (screening.isOv == false ? context.locals.cinema.germanTranslation : '-'),
                          color: context.colors.neutralColors.textColors.mediumColors.base,
                        ),
                      ],
                    ),
                    Wrap(
                      spacing: LmuSizes.size_2,
                      runSpacing: LmuSizes.size_2,
                      children: [
                        LmuInTextVisual.text(title: cinema.type.getValue()),
                        if (screening.movie.budget != null)
                          LmuInTextVisual.text(title: '${screening.price.toStringAsFixed(2)} €'),
                        if (screening.movie.ratings.isNotEmpty)
                          LmuInTextVisual.text(title: screening.movie.ratings.first.rawRating),
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
  }
}
