import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../repository/api/models/screening_model.dart';
import '../util/screening_time.dart';

class ScreeningDetailsPage extends StatelessWidget {
  const ScreeningDetailsPage({
    super.key,
    required this.screening,
  });

  final ScreeningModel screening;

  @override
  Widget build(BuildContext context) {
    return LmuMasterAppBar.custom(
      collapsedTitle: screening.movie.title,
      leadingAction: LeadingAction.back,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 320,
                width: 220,
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
                          height: 320,
                          width: 220,
                          fit: BoxFit.cover,
                          semanticLabel: screening.movie.poster!.name,
                        );
                      } else {
                        return LmuSkeleton(
                          child: Container(
                            height: 320,
                            width: 220,
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
              const SizedBox(height: LmuSizes.size_24),
              LmuText.h1(screening.movie.title),
              const SizedBox(height: LmuSizes.size_24),
              LmuText.body(
                getScreeningTime(context: context, time: screening.entryTime),
                color: context.colors.neutralColors.textColors.mediumColors.base,
              ),
              const SizedBox(height: LmuSizes.size_24),
              Wrap(
                spacing: LmuSizes.size_2,
                runSpacing: LmuSizes.size_2,
                children: [
                  if (screening.movie.budget != null)
                    LmuInTextVisual.text(title: '${screening.price.toStringAsFixed(2)} €'),
                  if (screening.isOv != null)
                    LmuInTextVisual.text(
                      title: screening.isOv! ? context.locals.cinema.ov : context.locals.cinema.germanTranslation,
                    ),
                  if (screening.movie.releaseYear != null)
                    LmuInTextVisual.text(title: DateTime.parse(screening.movie.releaseYear!).year.toString()),
                  if (screening.movie.ratings.isNotEmpty)
                    LmuInTextVisual.text(
                      title:
                          '${screening.movie.ratings.first.source} ${screening.movie.ratings.first.rawRating.toString()}',
                    ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_24),
              if (screening.note != null)
                LmuContentTile(
                  content: [
                    LmuText.body(
                      screening.note,
                      color: context.colors.neutralColors.textColors.mediumColors.base,
                    ),
                  ],
                ),
              const SizedBox(height: LmuSizes.size_24),
              LmuListItem.action(
                title: screening.cinema.title,
                titleColor: context.colors.neutralColors.textColors.mediumColors.base,
                titleInTextVisuals: [LmuInTextVisual.text(title: screening.cinema.id)],
                actionType: LmuListItemAction.chevron,
                hasHorizontalPadding: false,
                hasDivider: true,
                onTap: () => print("Tapped"),
              ),
              LmuListItem.base(
                title: screening.location.address,
                titleColor: context.colors.neutralColors.textColors.mediumColors.base,
                hasHorizontalPadding: false,
                onTap: () => print("Tapped"),
              ),
              const SizedBox(height: LmuSizes.size_24),
              if (screening.movie.overview != null) LmuText.body(screening.movie.overview),
              const SizedBox(height: LmuSizes.size_96),
            ],
          ),
        ),
      ),
    );
  }
}
