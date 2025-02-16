import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../pages/screening_details_page.dart';
import '../repository/api/api.dart';
import '../routes/screening_details_data.dart';
import '../util/cinema_type.dart';
import '../util/screening_time.dart';

class ScreeningCard extends StatelessWidget {
  const ScreeningCard({
    Key? key,
    required this.screening,
    required this.cinemaScreenings,
    required this.isLastItem,
  }) : super(key: key);

  final ScreeningModel screening;
  final List<ScreeningModel> cinemaScreenings;
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    const double cardHeight = 165;

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ScreeningDetailsPage(
            screeningDetailsData: ScreeningDetailsData(
              screening: screening,
              cinemaScreenings: cinemaScreenings,
            ),
          ),
        ),
      ),
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
            SizedBox(
              height: cardHeight,
              width: 116,
              child: screening.movie.poster != null
                  ? ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(LmuRadiusSizes.mediumLarge),
                        bottomLeft: Radius.circular(LmuRadiusSizes.mediumLarge),
                      ),
                      child: FutureBuilder(
                        future: precacheImage(
                          NetworkImage(screening.movie.poster!.url),
                          context,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return Image.network(
                              screening.movie.poster!.url,
                              height: cardHeight,
                              width: 116,
                              fit: BoxFit.cover,
                              semanticLabel: screening.movie.poster!.name,
                            );
                          } else {
                            return LmuSkeleton(
                              child: Container(
                                height: cardHeight,
                                width: 116,
                                color: Colors.white,
                              ),
                            );
                          }
                        },
                      ),
                    )
                  : Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: context.colors.neutralColors.backgroundColors.mediumColors.base,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(LmuRadiusSizes.mediumLarge),
                          bottomLeft: Radius.circular(LmuRadiusSizes.mediumLarge),
                        ),
                      ),
                      child: Center(
                        child: LmuText.caption(
                          screening.movie.title,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(LmuSizes.size_16),
                child: Column(
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
                            maxLines: 2,
                            customOverFlow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: LmuSizes.size_4),
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
                        LmuInTextVisual.text(title: screening.cinema.type.getValue()),
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
