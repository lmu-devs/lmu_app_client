import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:core/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../repository/api/api.dart';
import '../routes/cinema_details_data.dart';
import '../routes/screening_details_data.dart';
import '../util/cinema_type.dart';
import '../util/screening_time.dart';
import '../widgets/trailer_card.dart';
import 'cinema_details_page.dart';

class ScreeningDetailsPage extends StatelessWidget {
  const ScreeningDetailsPage({
    super.key,
    required this.screeningDetailsData,
  });

  final ScreeningDetailsData screeningDetailsData;

  @override
  Widget build(BuildContext context) {
    ScreeningModel screening = screeningDetailsData.screening;
    List<ScreeningModel> cinemaScreenings = screeningDetailsData.cinemaScreenings;

    return LmuMasterAppBar.custom(
      collapsedTitle: screening.movie.title,
      leadingAction: LeadingAction.back,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: Column(
                children: [
                  screening.movie.poster != null
                      ? ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(LmuRadiusSizes.mediumLarge),
                          ),
                          child: Image.network(
                            screening.movie.poster!.url,
                            height: 320,
                            width: 220,
                            fit: BoxFit.cover,
                            semanticLabel: screening.movie.poster!.name,
                          ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: LmuSizes.size_24),
                  LmuText.h1(
                    screening.movie.title,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: LmuSizes.size_24),
                  LmuText.body(
                    getScreeningTime(context: context, time: screening.entryTime),
                    color: context.colors.neutralColors.textColors.mediumColors.base,
                  ),
                  const SizedBox(height: LmuSizes.size_24),
                  if (screening.movie.budget != null ||
                      screening.isOv != null ||
                      screening.movie.releaseYear != null ||
                      screening.movie.ratings.isNotEmpty) ...[
                    Wrap(
                      spacing: LmuSizes.size_4,
                      runSpacing: LmuSizes.size_6,
                      alignment: WrapAlignment.center,
                      children: [
                        if (screening.movie.budget != null)
                          LmuInTextVisual.text(
                              title: '${screening.price.toStringAsFixed(2)} €', size: InTextVisualSize.large),
                        if (screening.isOv != null)
                          LmuInTextVisual.text(
                            title: screening.isOv! ? context.locals.cinema.ov : context.locals.cinema.germanTranslation,
                            size: InTextVisualSize.large,
                          ),
                        if (screening.movie.releaseYear != null)
                          LmuInTextVisual.text(
                            title: DateTime.parse(screening.movie.releaseYear!).year.toString(),
                            size: InTextVisualSize.large,
                          ),
                        if (screening.movie.ratings.isNotEmpty)
                          LmuInTextVisual.text(
                            title:
                                '${_normalizeRatingSource(screening.movie.ratings.first.source)} ${screening.movie.ratings.first.rawRating.toString()}',
                            size: InTextVisualSize.large,
                          ),
                      ],
                    ),
                    const SizedBox(height: LmuSizes.size_24),
                  ],
                  if (screening.externalLink != null) ...[
                    LmuButtonRow(
                      buttons: [
                        LmuButton(
                          title: 'Website',
                          emphasis: ButtonEmphasis.secondary,
                          onTap: () => LmuUrlLauncher.launchWebsite(
                            url: screening.externalLink!,
                            context: context,
                          ),
                        ),
                        LmuButton(
                          title: context.locals.cinema.share,
                          emphasis: ButtonEmphasis.secondary,
                          onTap: () => Share.share(screening.externalLink!),
                        ),
                      ],
                    ),
                    const SizedBox(height: LmuSizes.size_24),
                  ],
                  if (screening.note != null && screening.note!.isNotEmpty) ...[
                    LmuContentTile(
                      content: [
                        Padding(
                          padding: const EdgeInsets.all(LmuSizes.size_8),
                          child: LmuText.body(
                            screening.note,
                            color: context.colors.neutralColors.textColors.mediumColors.base,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: LmuSizes.size_24),
                  ],
                  LmuListItem.action(
                    subtitle: screening.cinema.title,
                    subtitleTextColor: context.colors.neutralColors.textColors.mediumColors.base,
                    subtitleInTextVisuals: [
                      LmuInTextVisual.text(
                        title: screening.cinema.type.getValue(),
                        textColor: screening.cinema.type.getTextColor(context),
                        backgroundColor: screening.cinema.type.getBackgroundColor(context),
                      )
                    ],
                    actionType: LmuListItemAction.chevron,
                    hasHorizontalPadding: false,
                    hasDivider: true,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CinemaDetailsPage(
                          cinemaDetailsData: CinemaDetailsData(
                            cinema: screening.cinema,
                            screenings: cinemaScreenings,
                          ),
                        ),
                      ),
                    ),
                  ),
                  LmuListItem.base(
                    subtitle: screening.cinema.cinemaLocation.address,
                    subtitleTextColor: context.colors.neutralColors.textColors.mediumColors.base,
                    hasHorizontalPadding: false,
                    trailingArea: Icon(
                      LucideIcons.map,
                      size: LmuIconSizes.mediumSmall,
                      color: context.colors.neutralColors.textColors.weakColors.base,
                    ),
                    onTap: () => LmuBottomSheet.show(
                      context,
                      content: NavigationSheet(
                        latitude: screening.cinema.cinemaLocation.latitude,
                        longitude: screening.cinema.cinemaLocation.longitude,
                        address: screening.cinema.cinemaLocation.address,
                      ),
                    ),
                  ),
                  const SizedBox(height: LmuSizes.size_24),
                  if (screening.movie.tagline != null && screening.movie.tagline!.isNotEmpty) ...[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: LmuText(screening.movie.tagline!, weight: FontWeight.w600),
                    ),
                    SizedBox(height: screening.movie.overview != null ? LmuSizes.size_12 : LmuSizes.size_24),
                  ],
                  if (screening.movie.overview != null) ...[
                    ExpandableText(
                      text: screening.movie.overview!,
                      maxLines: 8,
                      amountOfHorizontalPadding: LmuSizes.size_32,
                    ),
                    const SizedBox(height: LmuSizes.size_24),
                  ],
                ],
              ),
            ),
            if (screening.movie.trailers.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.only(left: LmuSizes.size_16),
                child: LmuTileHeadline.base(title: 'Trailer'),
              ),
              SizedBox(
                height: 195,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: screening.movie.trailers.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: index == 0
                          ? const EdgeInsets.only(left: LmuSizes.size_16)
                          : index == (screening.movie.trailers.length - 1)
                              ? const EdgeInsets.only(right: LmuSizes.size_8)
                              : EdgeInsets.zero,
                      child: TrailerCard(
                        trailer: screening.movie.trailers[index],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: LmuSizes.size_24),
            ],
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: Column(
                children: [
                  LmuContentTile(
                    content: [
                      LmuListItem.base(
                        subtitle: context.locals.cinema.entry,
                        trailingTitle: DateFormat('HH:mm').format(DateTime.parse(screening.entryTime)),
                      ),
                      screening.endTime != null
                          ? LmuListItem.base(
                              subtitle:
                                  '${context.locals.cinema.movie} (${DateTime.parse(screening.endTime!).difference(DateTime.parse(screening.startTime)).inHours}:${(DateTime.parse(screening.endTime!).difference(DateTime.parse(screening.startTime)).inMinutes % 60).toString().padLeft(2, '0')}h)',
                              trailingTitle:
                                  '${DateFormat('HH:mm').format(DateTime.parse(screening.startTime))} - ${DateFormat('HH:mm').format(
                                DateTime.parse(screening.endTime!),
                              )}',
                            )
                          : LmuListItem.base(
                              subtitle: context.locals.cinema.start,
                              trailingTitle: DateFormat('HH:mm').format(DateTime.parse(screening.startTime)),
                            ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: LmuSizes.size_96),
          ],
        ),
      ),
    );
  }

  String _normalizeRatingSource(String ratingSource) {
    if (ratingSource == 'ROTTEN_TOMATOES') {
      return 'Rotten Tomatoes';
    } else if (ratingSource == 'METACRITIC') {
      return 'Metacritic';
    } else {
      return ratingSource;
    }
  }
}
