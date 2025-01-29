import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:core/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../repository/api/api.dart';
import '../routes/cinema_details_data.dart';
import '../util/cinema_type.dart';
import '../widgets/screening_card.dart';

class CinemaDetailsPage extends StatelessWidget {
  const CinemaDetailsPage({
    super.key,
    required this.cinemaDetailsData,
  });

  final CinemaDetailsData cinemaDetailsData;

  @override
  Widget build(BuildContext context) {
    final CinemaModel cinema = cinemaDetailsData.cinema;
    final List<ScreeningModel> screenings = cinemaDetailsData.screenings;

    return LmuMasterAppBar(
      largeTitle: cinema.title,
      leadingAction: LeadingAction.back,
      largeTitleTrailingWidgetAlignment: MainAxisAlignment.start,
      largeTitleTrailingWidget: Container(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_4),
        decoration: BoxDecoration(
          color: context.colors.neutralColors.backgroundColors.mediumColors.base,
          borderRadius: BorderRadius.circular(LmuRadiusSizes.small),
        ),
        child: LmuText.bodySmall(cinema.type.getValue()),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LmuButtonRow(
              buttons: [
                LmuButton(
                  title: 'Instagram',
                  emphasis: ButtonEmphasis.secondary,
                  onTap: () => LmuUrlLauncher.launchWebsite(
                    url: cinema.instagramLink,
                    context: context,
                    mode: LmuUrlLauncherMode.inAppWebView,
                  ),
                ),
                LmuButton(
                  title: 'Website',
                  emphasis: ButtonEmphasis.secondary,
                  onTap: () => LmuUrlLauncher.launchWebsite(
                    url: cinema.externalLink,
                    context: context,
                    mode: LmuUrlLauncherMode.inAppWebView,
                  ),
                ),
              ],
            ),
            const SizedBox(height: LmuSizes.size_16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: Column(
                children: [
                  LmuListItem.base(
                    trailingArea: Icon(
                      LucideIcons.map,
                      size: LmuIconSizes.mediumSmall,
                      color: context.colors.neutralColors.textColors.weakColors.base,
                    ),
                    subtitle: cinema.cinemaLocation.address,
                    hasHorizontalPadding: false,
                    hasDivider: true,
                    onTap: () {
                      cinema.cinemaLocation.latitude != null && cinema.cinemaLocation.longitude != null
                          ? LmuBottomSheet.show(
                              context,
                              content: NavigationSheet(
                                latitude: cinema.cinemaLocation.latitude!,
                                longitude: cinema.cinemaLocation.longitude!,
                                address: cinema.cinemaLocation.address,
                              ),
                            )
                          : LmuToast.show(
                              context: context,
                              message: 'No Location for ${cinema.title} Available',
                            );
                    },
                  ),
                  ...List.generate(
                    cinema.descriptions.length,
                    (index) {
                      final description = cinema.descriptions[index];
                      return LmuListItem.base(
                        leadingArea: LmuText(description.emoji),
                        subtitle: description.description,
                        hasHorizontalPadding: false,
                        hasDivider: true,
                      );
                    },
                  ),
                  const SizedBox(height: LmuSizes.size_32),
                  LmuTileHeadline.base(title: context.locals.cinema.moviesTitle),
                  ...List.generate(screenings.length, (index) {
                    final screening = screenings[index];
                    return ScreeningCard(
                      screening: screening,
                      isLastItem: index == screenings.length - 1,
                    );
                  }),
                  const SizedBox(height: LmuSizes.size_96),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
