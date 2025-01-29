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

import '../repository/api/models/screening_model.dart';
import '../util/screening_time.dart';
import '../widgets/trailer_card.dart';

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
              screening.movie.poster != null
                  ? SizedBox(
                      height: 320,
                      width: 220,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(LmuRadiusSizes.mediumLarge),
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
                      ),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: LmuSizes.size_24),
              LmuText.h1(screening.movie.title),
              const SizedBox(height: LmuSizes.size_24),
              LmuText.body(
                getScreeningTime(context: context, time: screening.entryTime),
                color: context.colors.neutralColors.textColors.mediumColors.base,
              ),
              const SizedBox(height: LmuSizes.size_24),
              if (screening.movie.budget != null &&
                  screening.isOv != null &&
                  screening.movie.releaseYear != null &&
                  screening.movie.ratings.isNotEmpty) ...[
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
                trailingArea: Icon(
                  LucideIcons.map,
                  size: LmuIconSizes.mediumSmall,
                  color: context.colors.neutralColors.textColors.weakColors.base,
                ),
                onTap: () => screening.location.latitude != null && screening.location.longitude != null
                    ? LmuBottomSheet.show(
                        context,
                        content: NavigationSheet(
                          latitude: screening.location.latitude!,
                          longitude: screening.location.longitude!,
                          address: screening.location.address,
                        ),
                      )
                    : LmuToast.show(
                        context: context,
                        message: 'No Location for ${screening.cinema.title} Available',
                      ),
              ),
              const SizedBox(height: LmuSizes.size_24),
              if (screening.movie.overview != null) ...[
                LmuText.body(screening.movie.overview),
                const SizedBox(height: LmuSizes.size_24),
              ],
              if (screening.movie.trailers.isNotEmpty) ...[
                LmuTileHeadline.base(title: 'Trailer'),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: screening.movie.trailers.length,
                    itemBuilder: (context, index) {
                      return TrailerCard(
                        trailer: screening.movie.trailers[index],
                      );
                    },
                  ),
                ),
                const SizedBox(height: LmuSizes.size_24),
              ],
              LmuContentTile(
                content: [
                  LmuListItem.base(
                    title: 'Entry Time',
                    titleColor: context.colors.neutralColors.textColors.mediumColors.base,
                    trailingTitle: DateFormat('HH:mm').format(DateTime.parse(screening.entryTime)),
                  ),
                  screening.endTime != null ?
                    LmuListItem.base(
                      title:
                          'Movie (${DateTime.parse(screening.endTime!).difference(DateTime.parse(screening.startTime)).inHours}:${(DateTime.parse(screening.endTime!).difference(DateTime.parse(screening.startTime)).inMinutes % 60).toString().padLeft(2, '0')}h)',
                      titleColor: context.colors.neutralColors.textColors.mediumColors.base,
                      trailingTitle:
                          '${DateFormat('HH:mm').format(DateTime.parse(screening.startTime))} - ${DateFormat('HH:mm').format(
                        DateTime.parse(screening.endTime!),
                      )}',
                    ) : LmuListItem.base(
                    title:
                    'Start Time',
                    titleColor: context.colors.neutralColors.textColors.mediumColors.base,
                    trailingTitle:
                    DateFormat('HH:mm').format(DateTime.parse(screening.startTime)),
                  ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_96),
            ],
          ),
        ),
      ),
    );
  }
}
