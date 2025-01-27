import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../repository/api/models/screening_model.dart';

class ScreeningCard extends StatelessWidget {
  const ScreeningCard({
    Key? key,
    required this.screening,
    required this.isLastItem,
  }) : super(key: key);

  final ScreeningModel screening;
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print(screening.movie.title),
      child: Container(
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
              height: 165,
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
                  : Center(
                child: LmuText.caption(screening.movie.title),
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
                            maxLines: null,
                            customOverFlow: TextOverflow.visible,
                          ),
                        ),
                        const SizedBox(height: LmuSizes.size_4),
                        LmuText.bodySmall(
                          DateFormat("hh:mm • dd.MM.yyyy")
                              .format(DateTime.parse(screening.entryTime)),
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
                        // Uncomment if needed
                        // LmuInTextVisual.text(title: screening.movie.budget.toString()),
                        const SizedBox(width: LmuSizes.size_2),
                        // Uncomment if needed
                        // LmuInTextVisual.text(title: screening.movie.ratings.first.normalizedRating.toString()),
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
