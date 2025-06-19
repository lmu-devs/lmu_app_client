import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../repository/api/api.dart';
import '../routes/cinema_details_data.dart';
import '../util/cinema_type.dart';
import '../widgets/screenings_list.dart';

class CinemaDetailsPage extends StatelessWidget {
  const CinemaDetailsPage({
    super.key,
    required this.cinemaDetailsData,
    this.withAppBar = true,
  });

  final CinemaDetailsData cinemaDetailsData;
  final bool withAppBar;

  @override
  Widget build(BuildContext context) {
    final CinemaModel cinema = cinemaDetailsData.cinema;
    final List<ScreeningModel> screenings = cinemaDetailsData.screenings;

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: LmuSizes.size_16),
        LmuButtonRow(
          buttons: [
            LmuButton(
              title: 'Instagram',
              emphasis: ButtonEmphasis.secondary,
              onTap: () => LmuUrlLauncher.launchWebsite(
                url: cinema.instagramLink,
                context: context,
                mode: LmuUrlLauncherMode.externalApplication,
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
                subtitle: cinema.location.address,
                hasHorizontalPadding: false,
                hasDivider: true,
                onTap: () => LmuBottomSheet.show(
                  context,
                  content: NavigationSheet(id: cinema.id, location: cinema.location),
                ),
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
              ScreeningsList(
                cinemas: [cinema],
                screenings: screenings,
                hasFilterRow: false,
                type: cinema.type,
              ),
              const SizedBox(height: LmuSizes.size_96),
            ],
          ),
        ),
      ],
    );

    if (!withAppBar) return content;

    return LmuScaffold(
      appBar: LmuAppBarData.image(
        largeTitle: cinema.title,
        leadingAction: LeadingAction.back,
        imageUrls: cinema.images != null ? cinema.images!.map((image) => image.url).toList() : [],
        largeTitleTrailingWidgetAlignment: MainAxisAlignment.start,
        largeTitleTrailingWidget: LmuInTextVisual.text(
          title: cinema.type.getValue(),
          textColor: cinema.type.getTextColor(context),
          backgroundColor: cinema.type.getBackgroundColor(context),
        ),
      ),
      body: SingleChildScrollView(child: content),
    );
  }
}
