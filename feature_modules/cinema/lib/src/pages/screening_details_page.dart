import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:core_routes/cinema.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../repository/api/api.dart';
import '../routes/cinema_details_data.dart';
import '../routes/screening_details_data.dart';
import '../services/cinema_user_preference_service.dart';
import '../util/cinema_type.dart';
import '../util/screening_time.dart';
import '../widgets/screening_quick_fact_section.dart';
import '../widgets/trailer_card.dart';

class ScreeningDetailsPage extends StatelessWidget {
  const ScreeningDetailsPage({
    super.key,
    required this.screeningDetailsData,
  });

  final ScreeningDetailsData screeningDetailsData;

  @override
  Widget build(BuildContext context) {
    CinemaModel cinema = screeningDetailsData.cinema;
    ScreeningModel screening = screeningDetailsData.screening;
    List<ScreeningModel> cinemaScreenings = screeningDetailsData.cinemaScreenings;

    return LmuScaffold(
      appBar: LmuAppBarData.custom(
        collapsedTitle: screening.movie.title,
        leadingAction: LeadingAction.back,
        trailingWidgets: [
          ValueListenableBuilder<List<String>>(
            valueListenable: GetIt.I<CinemaUserPreferenceService>().likedScreeningsIdsNotifier,
            builder: (context, likedScreeningIds, child) {
              return GestureDetector(
                onTap: () async {
                  await GetIt.I<CinemaUserPreferenceService>().toggleLikedScreeningId(screening.id);
                  LmuVibrations.secondary();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: LmuSizes.size_4),
                  child: StarIcon(
                    disabledColor: context.colors.neutralColors.backgroundColors.mediumColors.active,
                    isActive: likedScreeningIds.contains(screening.id),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: Column(
                children: [
                  screening.movie.poster != null
                      ? Semantics(
                          label: screening.movie.poster!.name,
                          child: Container(
                            height: 320,
                            width: 220,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(LmuRadiusSizes.mediumLarge),
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
                  SizedBox(height: screening.movie.genres.isNotEmpty ? LmuSizes.size_8 : LmuSizes.size_24),
                  if (screening.movie.genres.isNotEmpty) ...[
                    LmuText.body(
                      screening.movie.genres.length > 1
                          ? '${screening.movie.genres.sublist(0, screening.movie.genres.length - 1).join(', ')} ${context.locals.cinema.and} ${screening.movie.genres.last}'
                          : screening.movie.genres.first,
                      color: context.colors.neutralColors.textColors.mediumColors.base,
                    ),
                    const SizedBox(height: LmuSizes.size_24),
                  ],
                  if (screening.movie.budget != null ||
                      screening.isOv != null ||
                      screening.movie.releaseYear != null ||
                      screening.movie.ratings.isNotEmpty) ...[
                    ScreeningQuickFactsSection(screening: screening),
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
                          title: context.locals.app.share,
                          emphasis: ButtonEmphasis.secondary,
                          onTap: () {
                            final params = ShareParams(uri: Uri.parse(screening.externalLink!));
                            SharePlus.instance.share(params);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: LmuSizes.size_24),
                  ],
                  if (screening.note != null && screening.note!.isNotEmpty) ...[
                    LmuContentTile(
                      content: Padding(
                        padding: const EdgeInsets.all(LmuSizes.size_8),
                        child: LmuText.body(
                          screening.note,
                          color: context.colors.neutralColors.textColors.mediumColors.base,
                        ),
                      ),
                    ),
                    const SizedBox(height: LmuSizes.size_24),
                  ],
                  LmuListItem.action(
                    subtitle: cinema.title,
                    subtitleTextColor: context.colors.neutralColors.textColors.mediumColors.base,
                    subtitleInTextVisuals: [
                      LmuInTextVisual.text(
                        title: cinema.type.getValue(),
                        textColor: cinema.type.getTextColor(context),
                        backgroundColor: cinema.type.getBackgroundColor(context),
                      )
                    ],
                    actionType: LmuListItemAction.chevron,
                    hasHorizontalPadding: false,
                    hasDivider: true,
                    onTap: () => CinemaDetailsRoute(
                      CinemaDetailsData(cinema: cinema, screenings: cinemaScreenings),
                    ).push(context),
                  ),
                  LmuListItem.base(
                    subtitle: cinema.location.address,
                    subtitleTextColor: context.colors.neutralColors.textColors.mediumColors.base,
                    hasHorizontalPadding: false,
                    trailingArea: Icon(
                      LucideIcons.map,
                      size: LmuIconSizes.mediumSmall,
                      color: context.colors.neutralColors.textColors.weakColors.base,
                    ),
                    onTap: () => LmuBottomSheet.show(
                      context,
                      content: NavigationSheet(id: cinema.id, location: cinema.location),
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
                    contentList: [
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
}
